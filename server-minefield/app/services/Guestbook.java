package services;

import play.Logger;
import play.inject.ApplicationLifecycle;

import javax.inject.Inject;
import javax.inject.Singleton;
import java.time.Clock;
import java.time.Instant;
import java.util.concurrent.CompletableFuture;

/**
 * Guestbook handling.
 */
@Singleton
public class Guestbook {

    @Inject
    public Guestbook() {
    }

}
