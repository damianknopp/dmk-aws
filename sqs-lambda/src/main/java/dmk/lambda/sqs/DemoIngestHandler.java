package dmk.lambda.sqs;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import dmk.aws.model.S3KeyMessage;

public class DemoIngestHandler implements RequestHandler<S3KeyMessage, Integer> {

    public Integer handleRequest(S3KeyMessage message, Context context) {
        LambdaLogger logger = context.getLogger();
        logger.log("received : " + message);
        return 0;
    }
}
