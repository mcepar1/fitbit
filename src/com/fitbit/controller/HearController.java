package com.fitbit.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.joda.time.LocalDate;

import com.fitbit.api.FitbitAPIException;
import com.fitbit.api.client.LocalUserDetail;
import com.fitbit.api.common.model.heart.Heart;
import com.fitbit.api.common.service.FitbitApiService;
import com.fitbit.api.model.FitbitUser;
import com.fitbit.utils.Constants;
import com.fitbit.utils.SessionUtils;

/**
 * Servlet implementation class HearController
 */
@WebServlet("/heart")
public class HearController extends FitbitServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			// "2012-05-16"
			// "2012-05-17"
			if (this.verifyGetParameters(request).size() == 0) {
				Heart h = SessionUtils
						.getClientService(request)
						.getClient()
						.getLoggedHeartRate(
								new LocalUserDetail(Constants.LOCAL_USER_ID),
								FitbitUser.CURRENT_AUTHORIZED_USER,
								FitbitApiService
										.getValidLocalDateOrNull(request
												.getParameter(Constants.DATE_PARAMETER)));
				request.setAttribute("heart", h);
				request.setAttribute(Constants.DATE_PARAMETER, request.getParameter(Constants.DATE_PARAMETER));
				request.getRequestDispatcher("/heart/heart.jsp").forward(
						request, response);
			} else {
				request.setAttribute(Constants.ERRORS_PARAMETER, this.verifyGetParameters(request));
				request.getRequestDispatcher("/heart/heart.jsp").forward(
						request, response);
			}

		} catch (FitbitAPIException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		LocalUserDetail localUser = new LocalUserDetail(Constants.LOCAL_USER_ID);
		String tracker = request.getParameter("tracker");
		int rate = Integer.parseInt(request.getParameter("rate"));
		LocalDate date = FitbitApiService.getValidLocalDateOrNull(request
				.getParameter(Constants.DATE_PARAMETER));
		String time = request.getParameter("time");

		try {
			SessionUtils.getClientService(request).getClient()
					.logHeartRate(localUser, tracker, rate, date, time);
		} catch (FitbitAPIException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		this.doGet(request, response);
	}

	@Override
	protected List<String> verifyGetParameters(HttpServletRequest request) {
		List<String> errors = new ArrayList<String>();
		if (request.getParameter(Constants.DATE_PARAMETER) == null || request.getParameter(Constants.DATE_PARAMETER).length() == 0)
		{
			errors.add(Constants.DATE_MISSING_MESSAGE);
		}
		
		if (FitbitApiService.getValidLocalDateOrNull(request.getParameter(Constants.DATE_PARAMETER)) == null)
		{
			errors.add(Constants.DATE_INVALID_FORMAT_MESSAGE);
		}
		return errors;
	}

	@Override
	protected List<String> verifyPostParameters(HttpServletRequest request) {
		// TODO Auto-generated method stub
		return null;
	}

}
