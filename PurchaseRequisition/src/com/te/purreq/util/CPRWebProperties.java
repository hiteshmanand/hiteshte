package com.te.purreq.util;

import com.tycoelectronics.ets.commons.configuration.ConfigLocator;

public class CPRWebProperties {
	private static final String CONFIG_ID = "TECPRConfig";
	public static final String CENTRIFY_OVERRIDE_USERID =   "centrifyOverrideUserID";
	public static final String CENTRIFY_DISABLED =   "centrifyDisabled";
	
	private CPRWebProperties() {}
		
	private static String getResourceString(String resourceName) {
		return ConfigLocator.getInstance().getConfig(CONFIG_ID).getString(resourceName);
	}
	
	public static String getCentrifyOverrideUserID() {
		return getResourceString(CENTRIFY_OVERRIDE_USERID);
	}

	public static boolean getCentrifyDisabledLocally() {
		return true;
	}
	
}
