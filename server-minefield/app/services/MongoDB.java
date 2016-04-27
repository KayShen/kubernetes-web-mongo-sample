package services;

import com.mongodb.DB;
import com.mongodb.MongoClient;
import com.mongodb.ServerAddress;
import com.mongodb.WriteConcern;
import com.typesafe.config.ConfigFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import play.Environment;

import javax.inject.Inject;
import javax.inject.Singleton;
import java.util.ArrayList;
import java.util.List;


/**
 * Guestbook handling.
 */
@Singleton
public class MongoDB {
	private static final Logger log = LoggerFactory.getLogger(MongoDB.class);

	private final DB database;

	private final MongoClient mongoClient;

	@Inject
	public MongoDB(final Environment environment) {

		final int port = ConfigFactory.load().getInt("mongodb.port");
		final String host = ConfigFactory.load().getString("mongodb.host");
		final List<String> cluster = ConfigFactory.load().getStringList("mongodb.cluster.hosts");
		final String database = ConfigFactory.load().getString("mongodb.database");


		if (environment.isDev()) {
			log.debug("Connecting to MongoDB instance " + host + ":" + port + " using database " + database);
			this.mongoClient = new MongoClient(host, port);

		} else {
			log.debug("Connecting to MongoDB cluster with hosts " + cluster.toString() + ":" + port +
					" using database " + database);

			final List<ServerAddress> serverAddresses = new ArrayList<>();
			cluster.stream().forEach((element) -> serverAddresses.add(new ServerAddress(element, port)));

			this.mongoClient = new MongoClient(serverAddresses);
		}

		this.mongoClient.setWriteConcern(WriteConcern.ACKNOWLEDGED);
		this.database = mongoClient.getDB(ConfigFactory.load().getString("mongodb.database"));
	}

	public DB getDatabase() {
		return database;
	}

	public MongoClient getMongoClient() {
		return mongoClient;
	}
}
