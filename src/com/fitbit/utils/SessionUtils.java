package com.fitbit.utils;

import javax.servlet.http.HttpServletRequest;

import com.fitbit.api.client.FitbitApiClientAgent;
import com.fitbit.api.client.service.FitbitAPIClientService;

public class SessionUtils {
	
	public static final String CLIENT_SERVICE = "cService";
	
	public static void setClientService (HttpServletRequest request, FitbitAPIClientService<FitbitApiClientAgent> apiClientService) {
		request.getSession().setAttribute(SessionUtils.CLIENT_SERVICE, apiClientService);
	}
	
	public static FitbitAPIClientService<FitbitApiClientAgent> getClientService (HttpServletRequest request) {
		return (FitbitAPIClientService<FitbitApiClientAgent>) request.getSession().getAttribute(SessionUtils.CLIENT_SERVICE);
	}
	
	
}
