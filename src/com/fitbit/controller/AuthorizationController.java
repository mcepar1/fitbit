package com.fitbit.controller;

import java.io.IOException;
import java.util.Properties;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.joda.time.LocalDate;

import com.fitbit.api.FitbitAPIException;
import com.fitbit.api.client.FitbitAPIEntityCache;
import com.fitbit.api.client.FitbitApiClientAgent;
import com.fitbit.api.client.FitbitApiCredentialsCache;
import com.fitbit.api.client.FitbitApiCredentialsCacheMapImpl;
import com.fitbit.api.client.FitbitApiEntityCacheMapImpl;
import com.fitbit.api.client.FitbitApiSubscriptionStorage;
import com.fitbit.api.client.FitbitApiSubscriptionStorageInMemoryImpl;
import com.fitbit.api.client.LocalUserDetail;
import com.fitbit.api.client.service.FitbitAPIClientService;
import com.fitbit.api.common.model.heart.Heart;
import com.fitbit.api.common.model.heart.HeartLog;
import com.fitbit.api.common.model.user.UserInfo;
import com.fitbit.api.common.service.FitbitApiService;
import com.fitbit.api.model.APIResourceCredentials;
import com.fitbit.api.model.FitbitUser;
import com.fitbit.utils.SessionUtils;

/**
 * Created by IntelliJ IDEA.
 * User: Kiryl
 * Date: 6/22/11
 * Time: 7:05 AM
 */
@WebServlet(loadOnStartup=1, urlPatterns="/auth")
public class AuthorizationController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	public static final String OAUTH_TOKEN = "oauth_token";
    public static final String OAUTH_VERIFIER = "oauth_verifier";

    private FitbitAPIEntityCache entityCache = new FitbitApiEntityCacheMapImpl();
    private FitbitApiCredentialsCache credentialsCache = new FitbitApiCredentialsCacheMapImpl();
    private FitbitApiSubscriptionStorage subscriptionStore = new FitbitApiSubscriptionStorageInMemoryImpl();

    private String apiBaseUrl;
    private String fitbitSiteBaseUrl;
    private String exampleBaseUrl;
    private String clientConsumerKey;
    private String clientSecret;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        try {
            Properties properties = new Properties();
            properties.load(getClass().getClassLoader().getResourceAsStream("config.properties"));
            apiBaseUrl = properties.getProperty("apiBaseUrl");
            fitbitSiteBaseUrl = properties.getProperty("fitbitSiteBaseUrl");
            exampleBaseUrl = properties.getProperty("exampleBaseUrl").replace("/app", "");
            clientConsumerKey = properties.getProperty("clientConsumerKey");
            clientSecret = properties.getProperty("clientSecret");
        } catch (IOException e) {
            throw new ServletException("Exception during loading properties", e);
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        FitbitAPIClientService<FitbitApiClientAgent> apiClientService = new FitbitAPIClientService<FitbitApiClientAgent>(
                new FitbitApiClientAgent(apiBaseUrl, fitbitSiteBaseUrl, credentialsCache),
                clientConsumerKey,
                clientSecret,
                credentialsCache,
                entityCache,
                subscriptionStore
        );
        if (request.getParameter("completeAuthorization") != null) {
            String tempTokenReceived = request.getParameter(OAUTH_TOKEN);
            String tempTokenVerifier = request.getParameter(OAUTH_VERIFIER);
            APIResourceCredentials resourceCredentials = apiClientService.getResourceCredentialsByTempToken(tempTokenReceived);

            if (resourceCredentials == null) {
                throw new ServletException("Unrecognized temporary token when attempting to complete authorization: " + tempTokenReceived);
            }
            // Get token credentials only if necessary:
            if (!resourceCredentials.isAuthorized()) {
                // The verifier is required in the request to get token credentials:
                resourceCredentials.setTempTokenVerifier(tempTokenVerifier);
                try {
                    // Get token credentials for user:
                    apiClientService.getTokenCredentials(new LocalUserDetail(resourceCredentials.getLocalUserId()));
                } catch (FitbitAPIException e) {
                    throw new ServletException("Unable to finish authorization with Fitbit.", e);
                }
            }
            try {
            	SessionUtils.setClientService(request, apiClientService);
            	apiClientService.saveResourceCredentials(new LocalUserDetail(resourceCredentials.getLocalUserId()), resourceCredentials);
                UserInfo userInfo = apiClientService.getClient().getUserInfo(new LocalUserDetail(resourceCredentials.getLocalUserId()));
                
                request.setAttribute("userInfo", userInfo);
                request.getRequestDispatcher("/userProfile/userProfile.jsp").forward(request, response);
            } catch (FitbitAPIException e) {
                throw new ServletException("Exception during getting user info", e);
            }
        } else {
            try {
                response.sendRedirect(apiClientService.getResourceOwnerAuthorizationURL(new LocalUserDetail("-"), exampleBaseUrl + "/auth?completeAuthorization="));
            } catch (FitbitAPIException e) {
                throw new ServletException("Exception during performing authorization", e);
            }
        }
    }
}
