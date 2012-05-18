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
import org.joda.time.format.DateTimeFormat;

import com.fitbit.api.FitbitAPIException;
import com.fitbit.api.client.LocalUserDetail;
import com.fitbit.api.client.http.PostParameter;
import com.fitbit.api.common.service.FitbitApiService;
import com.fitbit.api.model.FitbitUser;
import com.fitbit.utils.Constants;
import com.fitbit.utils.SessionUtils;

/**
 * Servlet implementation class WeigthController
 */
@WebServlet("/weigth")
public class WeigthController extends HttpServlet {
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
				double weigth = SessionUtils
						.getClientService(request)
						.getClient()
						.getWeight(
								new LocalUserDetail(Constants.LOCAL_USER_ID),
								FitbitUser.CURRENT_AUTHORIZED_USER,
								FitbitApiService
										.getValidLocalDateOrNull(request
												.getParameter("date")));

				request.setAttribute("weigth", weigth);
				request.setAttribute("date", request.getParameter("date"));

			}
			request.getRequestDispatcher("/weigth/weigth.jsp").forward(request,
					response);

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
		double weigth = Double.parseDouble(request.getParameter("weigth"));
		LocalDate date = FitbitApiService.getValidLocalDateOrNull(request
				.getParameter("date"));

		try {
			List<PostParameter> params = new ArrayList<PostParameter>(2);
			params.add(new PostParameter("weight", weigth));
			params.add(new PostParameter("date", DateTimeFormat.forPattern(
					"yyyy-MM-dd").print(date)));

			SessionUtils.getClientService(request).getClient()
					.logBody(localUser, params);
		} catch (FitbitAPIException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		this.doGet(request, response);
	}

}
