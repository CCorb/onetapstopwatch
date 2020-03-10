package de.cco.onetapstopwatch;

import java.nio.ByteBuffer;

import android.os.Bundle;
import android.view.KeyEvent;
import android.util.Log;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class MainActivity extends FlutterActivity {

  /// ButtonHook Channel name
  private static final String CHANNELNAME = "de.cco.OneTapStopWatch/ButtonHook";
  MethodChannel channel;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    /// MethodChannel implementation
    GeneratedPluginRegistrant.registerWith(this);
    this.channel = new MethodChannel(getFlutterView(), CHANNELNAME);
    this.channel.setMethodCallHandler(new MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall call, Result result) {
      }
    });
  }

  /// Send info if button is pressed over channel
  /// prevent actual standard function of volume button
  @Override
  public boolean onKeyDown(int keyCode, KeyEvent event) {
    if (keyCode == KeyEvent.KEYCODE_POWER) {
      channel.invokeMethod(CHANNELNAME, "args", new Result() {
        @Override
        public void success(Object o) {
        }

        @Override
        public void error(String s, String s1, Object o) {
        }

        @Override
        public void notImplemented() {
        }
      });
      return true;
    }
    if (keyCode == KeyEvent.KEYCODE_VOLUME_UP) {
      channel.invokeMethod(CHANNELNAME, "args", new Result() {
        @Override
        public void success(Object o) {
        }

        @Override
        public void error(String s, String s1, Object o) {
        }

        @Override
        public void notImplemented() {
        }
      });
      return true;
    }
    if (keyCode == KeyEvent.KEYCODE_VOLUME_DOWN) {

      channel.invokeMethod(CHANNELNAME, "anything", new Result() {
        @Override
        public void success(Object o) {
        }

        @Override
        public void error(String s, String s1, Object o) {
        }

        @Override
        public void notImplemented() {
        }
      });

      return true;
    }

    return super.onKeyDown(keyCode, event);
  }
}
