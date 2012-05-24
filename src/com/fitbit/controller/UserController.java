package com.fitbit.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fitbit.api.FitbitAPIException;
import com.fitbit.api.client.LocalUserDetail;
import com.fitbit.api.common.model.user.UserInfo;
import com.fitbit.utils.Constants;
import com.fitbit.utils.SessionUtils;

/**
 * Servlet implementation class UserController
 */
@WebServlet("/user")
public class UserController extends FitbitServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			UserInfo userInfo = SessionUtils.getClientService(request)
					.getClient()
					.getUserInfo(new LocalUserDetail(Constants.LOCAL_USER_ID));

			request.setAttribute("userInfo", userInfo);
			request.getRequestDispatcher("/userProfile/userProfile.jsp")
					.forward(request, response);
		} catch (FitbitAPIException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	protected List<String> verifyGetParameters(HttpServletRequest request) {
		return null;
	}

	@Override
	protected List<String> verifyPostParameters(HttpServletRequest request) {
		return null;
	}

}
