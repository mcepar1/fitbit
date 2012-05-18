package com.fitbit.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.joda.time.LocalDate;

import com.fitbit.api.FitbitAPIException;
import com.fitbit.api.client.LocalUserDetail;
import com.fitbit.api.common.model.bp.Bp;
import com.fitbit.api.common.service.FitbitApiService;
import com.fitbit.api.model.FitbitUser;
import com.fitbit.utils.Constants;
import com.fitbit.utils.SessionUtils;

/**
 * Servlet implementation class BloodPressureController
 */
@WebServlet("/bp")
public class BloodPressureController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			// "2012-05-16"
			if (request.getParameter("date") != null) {
				Bp bp = SessionUtils
						.getClientService(request)
						.getClient()
						.getLoggedBp(
								new LocalUserDetail(Constants.LOCAL_USER_ID),
								FitbitUser.CURRENT_AUTHORIZED_USER,
								FitbitApiService
										.getValidLocalDateOrNull(request
												.getParameter("date")));

				request.setAttribute("bp", bp);
				request.setAttribute("date", request.getParameter("date"));

			}
			request.getRequestDispatcher("/bloodPressure/bloodPressure.jsp")
					.forward(request, response);

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
		int systolic = Integer.parseInt(request.getParameter("systolic"));
		int diastolic = Integer.parseInt(request.getParameter("diastolic"));
		LocalDate date = FitbitApiService.getValidLocalDateOrNull(request
				.getParameter("date"));

		try {

			SessionUtils.getClientService(request).getClient()
					.logBp(localUser, systolic, diastolic, date);
		} catch (FitbitAPIException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		this.doGet(request, response);
	}

}
