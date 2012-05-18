package com.fitbit.controller;

import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

public abstract class FitbitServlet extends HttpServlet {

	private static final long serialVersionUID = -2091124918035042852L;
	
	protected abstract List<String> verifyGetParameters(HttpServletRequest request);
	protected abstract List<String> verifyPostParameters(HttpServletRequest request);
}
