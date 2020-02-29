import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

public class AlertContacts {

    public static final String ACCOUNT_SID = "AC54f1fb7742008c2baa8b4d9fbd1c790e";

    public static final String AUTH_TOKEN = "060aaec376c2e4f9fb291c990f362216";

    public static void main(String[] args) {

        Twilio.init(ACCOUNT_SID, AUTH_TOKEN);

        Message message = Message
                .creator(new PhoneNumber("+14159352345"), // to
                        new PhoneNumber("+12058393432"), // from
                        "sah dude")
                .create();

        System.out.println(message.getSid());

    }
}
