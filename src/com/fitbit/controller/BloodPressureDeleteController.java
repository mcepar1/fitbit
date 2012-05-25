package com.fitbit.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.fitbit.api.FitbitAPIException;
import com.fitbit.api.client.LocalUserDetail;
import com.fitbit.utils.Constants;
import com.fitbit.utils.SessionUtils;

/**
 * Servlet implementation class DeleteController
 */
@WebServlet("/deleteBp")
public class BloodPressureDeleteController extends FitbitServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		List<String> errors = this.verifyGetParameters(request);
		JSONObject result = new JSONObject();

		if (errors.isEmpty()) {
			try {
				SessionUtils
						.getClientService(request)
						.getClient()
						.deleteBp(new LocalUserDetail(Constants.LOCAL_USER_ID),
								request.getParameter(Constants.ID_PARAMETER));
			} catch (FitbitAPIException e) {
				errors.add(Constants.NO_RESCORD_FOUND_ERROR);
			}
		}

		try {
			if (errors.isEmpty()) {
				result.put("succesful", true);
				result.put("message", Constants.DELETE_SUCCESSFUL);
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(result.toString());
			} else {
				result.put("succesful", false);
				result.put("message", Constants.NO_RESCORD_FOUND_ERROR);
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(result.toString());
			}
		} catch (JSONException e) {
			// TODO: handle exception
		}
	}

	@Override
	protected List<String> verifyGetParameters(HttpServletRequest request) {
		List<String> errors = new ArrayList<String>();

		if (request.getParameter(Constants.ID_PARAMETER) == null) {
			errors.add(Constants.NO_RESCORD_FOUND_ERROR);
		}
		return errors;
	}

	@Override
	protected List<String> verifyPostParameters(HttpServletRequest request) {
		return null;
	}

}
