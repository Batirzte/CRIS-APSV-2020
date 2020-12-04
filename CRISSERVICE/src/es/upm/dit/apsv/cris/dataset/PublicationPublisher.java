package es.upm.dit.apsv.cris.dataset;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

import com.google.cloud.pubsub.v1.Publisher;
import com.google.protobuf.ByteString;
import com.google.pubsub.v1.ProjectTopicName;
import com.google.pubsub.v1.PubsubMessage;

public class PublicationPublisher {

	public static void main(String[] args) throws Exception {
		ProjectTopicName topicName = ProjectTopicName.of("cris-256318","publications");

		String filename = (args.length > 0) ? args[0] : "publications.txt";
		System.out.println("Reading from: " + filename);
		List<String> messages = new BufferedReader(new FileReader(new File((filename))))
				.lines().collect(Collectors.toList());
		//Collections.shuffle(messages);
		Publisher publisher= Publisher.newBuilder(topicName).build();
		for (final String message : messages) {
			ByteString data = ByteString.copyFromUtf8(message);
			PubsubMessage pubsubMessage = PubsubMessage.newBuilder().setData(data).build();
			publisher.publish(pubsubMessage);
			Thread.sleep(100);
			System.out.println(message);
		}
		publisher.shutdown();
		publisher.awaitTermination(1, TimeUnit.MINUTES);
	}
}
