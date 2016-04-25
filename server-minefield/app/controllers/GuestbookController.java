package controllers;

import dao.GuestbookEntryDao;
import domain.GuestbookEntry;
import play.data.Form;
import play.data.FormFactory;
import play.mvc.Controller;
import play.mvc.Result;
import views.html.guestbook;
import views.html.index;

import javax.inject.Inject;
import java.util.List;

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
		return guestbookEntryDao.findAll();
	}

	public Result getGuestbookEntries(){
		return ok(guestbook.render("Guestbook", getGuestbookEntries(10)));
	}

	public Result postGuestbookEntry(){
		Form<GuestbookEntry> filledGuestbookEntryForm = guestbookEntryForm.bindFromRequest();
		if (filledGuestbookEntryForm.hasErrors()) {
			return badRequest(guestbook.render("Guestbook", getGuestbookEntries(10)));
		} else {
			GuestbookEntry guestbookEntry = filledGuestbookEntryForm.get();
			guestbookEntryDao.save(guestbookEntry);
			return getGuestbookEntries();
		}
	}

}
