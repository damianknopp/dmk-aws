package dmk.sqs.client;

import com.amazonaws.auth.DefaultAWSCredentialsProviderChain;
import com.amazonaws.services.sqs.AmazonSQS;
import com.amazonaws.services.sqs.AmazonSQSClientBuilder;
import com.amazonaws.services.sqs.model.Message;
import com.amazonaws.services.sqs.model.PurgeQueueRequest;
import com.amazonaws.services.sqs.model.ReceiveMessageRequest;
import com.amazonaws.services.sqs.model.SendMessageBatchRequest;
import com.amazonaws.services.sqs.model.SendMessageBatchRequestEntry;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.List;

/**
 * https://github.com/awsdocs/aws-doc-sdk-examples/blob/master/java/example_code/sqs/src/main/java/aws/example/sqs/SendReceiveMessages.java
 */
public class SQSHandler {
    private final Logger logger = LoggerFactory.getLogger(SQSHandler.class);

    private String queueUrl;

    public SQSHandler(String queueUrl) {
        super();
        this.queueUrl = queueUrl;
    }

    /**
     *
     * @param msgs
     */
    public void sendMessages(List<String> msgs) {
        var sqs = this.connectToSQS();
        // Send multiple messages to the queue
        var entries = new ArrayList<SendMessageBatchRequestEntry>(msgs.size() * 2);
        for (int i = 0; i < msgs.size(); i++) {
            var entry = new SendMessageBatchRequestEntry("msg-" + i, msgs.get(i)).withDelaySeconds(5);
            entries.add(entry);
        }
        logger.debug("sending {} entries to SQS", entries.size());
        var sendBatchRequest = new SendMessageBatchRequest();
        sendBatchRequest.withQueueUrl(this.queueUrl).withEntries(entries);
        sqs.sendMessageBatch(sendBatchRequest);
    }

    /**
     *
     */
    public List<Message> receiveMessages() {
        return this.receiveMessages(5);
    }

    /**
     *
     */
    public List<Message> receiveMessages(int batchSize) {
        batchSize = (batchSize < 1 || batchSize > 10) ? 1 : batchSize;
        var sqs = this.connectToSQS();
        // receive messages from the queue
        var request = new ReceiveMessageRequest();
        request.withMaxNumberOfMessages(batchSize).withQueueUrl(this.queueUrl);
        var msgs = sqs.receiveMessage(request).getMessages();
        logger.debug("{} received", msgs.size());
        return msgs;

    }

    /**
     * @param messages
     */
    public void deleteMessages(final List<Message> messages) {
        logger.debug("deleting {} message(s)", messages.size());
        var sqs = this.connectToSQS();
        // delete messages from the queue
        // tell the queue that this message was processed successfully
        // if not then the message will appear after the visibility timeout expires
        // also this appears to clean up "inflight" counts quicker
        for (Message m : messages) {
            sqs.deleteMessage(this.queueUrl, m.getReceiptHandle());
        }
    }

    /**
     * Delete all the messages in our configure queue
     */
    public void purgeMessages() {
        var sqs = this.connectToSQS();
        var request = new PurgeQueueRequest(this.queueUrl);
        logger.debug("purging {}", this.queueUrl);
        sqs.purgeQueue(request);
    }

    /**
     * connect to sqs using default client
     *
     * @return AmazonSQS
     */
    private AmazonSQS connectToSQS() {
        return AmazonSQSClientBuilder.standard().withCredentials(DefaultAWSCredentialsProviderChain.getInstance()).build();
    }

}
