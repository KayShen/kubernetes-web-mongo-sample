package controllers;

import play.mvc.Controller;
import play.mvc.Result;

/**
 * This controller handles requests to perform a healthcheck.
 */
public class MonitoringController extends Controller {

	public Result healthCheck() {
		return ok();
	}

}
