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
public class WeigthController extends FitbitServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			// "2012-05-16"
			if (this.verifyGetParameters(request).isEmpty()) {
				double weigth = SessionUtils
						.getClientService(request)
						.getClient()
						.getWeight(
								new LocalUserDetail(Constants.LOCAL_USER_ID),
								FitbitUser.CURRENT_AUTHORIZED_USER,
								FitbitApiService.getValidLocalDateOrNull(request
										.getParameter(Constants.DATE_PARAMETER)));

				request.setAttribute(Constants.WEIGTH_PARAMETER, weigth);
				request.setAttribute(Constants.DATE_PARAMETER,
						request.getParameter(Constants.DATE_PARAMETER));

			} else {
				request.setAttribute(Constants.ERRORS_PARAMETER,
						this.verifyGetParameters(request));
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

		if (this.verifyPostParameters(request).isEmpty()) {
			LocalUserDetail localUser = new LocalUserDetail(
					Constants.LOCAL_USER_ID);
			double weigth = Double.parseDouble(request
					.getParameter(Constants.WEIGTH_PARAMETER));
			LocalDate date = FitbitApiService.getValidLocalDateOrNull(request
					.getParameter(Constants.DATE_PARAMETER));

			try {
				List<PostParameter> params = new ArrayList<PostParameter>(2);
				params.add(new PostParameter(Constants.WEIGTH_PARAMETER, weigth));
				params.add(new PostParameter(Constants.DATE_PARAMETER,
						DateTimeFormat.forPattern(Constants.DATE_FORMAT).print(
								date)));

				SessionUtils.getClientService(request).getClient()
						.logBody(localUser, params);
			} catch (FitbitAPIException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			this.doGet(request, response);
		} else {
			request.setAttribute(Constants.ERRORS_PARAMETER,
					this.verifyPostParameters(request));
			request.getRequestDispatcher("/weigth/weigth.jsp").forward(request,
					response);
		}
	}

	@Override
	protected List<String> verifyGetParameters(HttpServletRequest request) {
		List<String> errors = new ArrayList<String>();
		if (request.getParameter(Constants.DATE_PARAMETER) == null
				|| request.getParameter(Constants.DATE_PARAMETER).length() == 0) {
			errors.add(Constants.DATE_MISSING_MESSAGE);
		}

		if (FitbitApiService.getValidLocalDateOrNull(request
				.getParameter(Constants.DATE_PARAMETER)) == null) {
			errors.add(Constants.DATE_INVALID_FORMAT_MESSAGE);
		}
		return errors;
	}

	@Override
	protected List<String> verifyPostParameters(HttpServletRequest request) {
		List<String> errors = this.verifyGetParameters(request);

		if (request.getParameter(Constants.WEIGTH_PARAMETER) == null
				|| request.getParameter(Constants.WEIGTH_PARAMETER).length() == 0) {
			errors.add(Constants.WEIGTH_PARAMETER_MISSING);
		}
		try {
			Double.parseDouble(request.getParameter(Constants.WEIGTH_PARAMETER));
		} catch (NumberFormatException e) {
			errors.add(Constants.WEIGTH_PARAMETER_NAN);
		}
		return errors;
	}

}
