package controllers;

import dao.GuestbookEntryDao;
import domain.GuestbookEntry;
import play.data.Form;
import play.data.FormFactory;
import play.mvc.Controller;
import play.mvc.Result;
import views.html.guestbook;

import javax.inject.Inject;
import java.awt.*;
import java.util.List;
import java.util.Random;

/**
 * This controller contains an action to handle HTTP requests
 * to the application's home page.
 */
public class GuestbookController extends Controller {

	private final FormFactory formFactory;

	private final GuestbookEntryDao guestbookEntryDao;

	private final Form<GuestbookEntry> guestbookEntryForm;

	@Inject
	public GuestbookController(final GuestbookEntryDao guestbookEntryDao, final FormFactory formFactory) {
		this.guestbookEntryDao = guestbookEntryDao;
		this.formFactory = formFactory;
		this.guestbookEntryForm = formFactory.form(GuestbookEntry.class);
	}

	/**
	 * An action that retrieves all guestbook entries.
	 */
	public List<GuestbookEntry> getGuestbookEntries(final int count) {
		return guestbookEntryDao.findAllSortByTimestampCreation(count);
	}

	public Result getGuestbookEntries(){
		return ok(guestbook.render("Guestbook", getGuestbookEntries(100), guestbookEntryForm));
	}

	public Result postGuestbookEntry(){
		Form<GuestbookEntry> filledGuestbookEntryForm = guestbookEntryForm.bindFromRequest();
		if (filledGuestbookEntryForm.hasErrors()) {
			return badRequest(guestbook.render("Guestbook", getGuestbookEntries(10), filledGuestbookEntryForm));
		} else {
			GuestbookEntry guestbookEntry = filledGuestbookEntryForm.get();
			guestbookEntry.setColor(getRandomHexColor());
			guestbookEntryDao.save(guestbookEntry);
			return redirect(routes.GuestbookController.getGuestbookEntries());
		}
	}

	public String getRandomHexColor(){
		final Random rand = new Random();
		float r = rand.nextFloat();
		float g = rand.nextFloat();
		float b = rand.nextFloat();
		Color randomColor = new Color(r, g, b);
		return "#"+Integer.toHexString(randomColor.getRGB()).substring(2);
	}

}
