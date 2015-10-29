package org.apache.cordova.plugin;

import java.util.List;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.net.Uri;

public class Yandexnavi extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("open")) {
            this.open(args, callbackContext);
            return true;
        }
        return false;
    }

    private void open(JSONArray args, CallbackContext callbackContext) throws JSONException {
    	Intent intent = new Intent("ru.yandex.yandexnavi.action.BUILD_ROUTE_ON_MAP");
        intent.setPackage("ru.yandex.yandexnavi");

        PackageManager pm = this.cordova.getActivity().getPackageManager();
        List<ResolveInfo> infos = pm.queryIntentActivities(intent, 0);

        // Проверяем, установлен ли Яндекс.Навигатор
        if (infos == null || infos.size() == 0) {
            // Если нет - будем открывать страничку Навигатора в Google Play
            intent = new Intent(Intent.ACTION_VIEW);
            intent.setData(Uri.parse("market://details?id=ru.yandex.yandexnavi"));
        } else {
        	if(!args.getString(0).isEmpty() && !args.getString(1).isEmpty()) {
	        	intent.putExtra("lat_from", args.getDouble(0));
	        	intent.putExtra("lon_from", args.getDouble(1));
        	}
            intent.putExtra("lat_to", args.getDouble(2));
            intent.putExtra("lon_to", args.getDouble(3));
        }

        // Запускаем нужную Activity
        this.cordova.getActivity().startActivity(intent);
    }
}