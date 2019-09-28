package dam.proyecto.android_remote_control_client;

import android.os.Bundle;
import android.view.MotionEvent;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import dam.proyecto.networking.SocketIOUtil;
import io.socket.client.Socket;
import io.socket.emitter.Emitter.Listener;

public class MainActivity extends AppCompatActivity {

    // elementos de la interfaz
    private EditText areaNotificaciones;
    private TextView labelServidor;
    // listeners para la interfaz
    private View.OnTouchListener touchListenerBotones;
    private View.OnTouchListener touchListenerSwitches;

    // conexiones y streams
    private String serverHOST = "192.168.1.3";
    private String serverPORT = "8080";

    // para conectar con nodejs
    private SocketIOUtil socketUtil = null;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //obtener los elementos de la interfaz
        labelServidor = findViewById(R.id.labelServidor);
        areaNotificaciones = findViewById(R.id.areaNotificaciones);

        crearListeners();

        // establecemos el esto del servidor
        ((EditText)findViewById(R.id.editText_host)).setText(serverHOST);
        ((EditText)findViewById(R.id.editText_port)).setText(serverPORT);

        // añadimos el touchlistener que maneja los botones de movimiento y el claxon
        findViewById(R.id.btn_fw).setOnTouchListener(touchListenerBotones);
        findViewById(R.id.btn_bw).setOnTouchListener(touchListenerBotones);
        findViewById(R.id.btn_rot_left).setOnTouchListener(touchListenerBotones);
        findViewById(R.id.btn_rot_right).setOnTouchListener(touchListenerBotones);
        findViewById(R.id.btn_claxon).setOnTouchListener(touchListenerBotones);

        //añadimos el touchListener para los botones de las luces
        findViewById(R.id.btn_luces).setOnTouchListener(touchListenerSwitches);
        findViewById(R.id.btn_sig_rot_left).setOnTouchListener(touchListenerSwitches);
        findViewById(R.id.btn_sig_rot_right).setOnTouchListener(touchListenerSwitches);
        findViewById(R.id.btn_emergencias).setOnTouchListener(touchListenerSwitches);
    }


    /**
     * Funciones para los botones del menu archivo ConectarCon..., ElegirServidor,
     * Desconectar, Salir.
     */
    // para conectar al servidor elegido
    public void archivoConectarCon(View vista) {
        conectarAlServidor();
    }


    // para desconectar del servidor
    public void archivoDesconectar(View vista) {
        if (socketUtil != null) {
            socketUtil.close();
            socketUtil = null;
        }

    }

    // para cerrar la aplicacion totalmente
    /*private void archivoSalir() {
        if(socketUtil!=null)socketUtil.close();
        Platform.exit();
    }*/

    /**
     * fin de las funciones del menu archivo
     */
    private void conectarAlServidor() {
        serverHOST = ((EditText)findViewById(R.id.editText_host)).getText().toString();
        serverPORT = ((EditText)findViewById(R.id.editText_port)).getText().toString();
        actualizarAreaNotificaciones("Intentando conectar con " + serverHOST + ":" + serverPORT + "...");
        if (socketUtil == null) {
            socketUtil = new SocketIOUtil(serverHOST, serverPORT);
            // manejador de mensajes recibidos que actualiza la interfaz
            socketUtil.getSocket().on(Socket.EVENT_MESSAGE, new Listener() {
                @Override
                public void call(Object... args) {
                    for (Object arg: args) {
                        actualizarAreaNotificaciones("Servidor: "+ arg);
                    }
                }
            });
        }
        socketUtil.connect();
        Toast.makeText(getApplicationContext(),"host: "+serverHOST+ "port:"+serverPORT , Toast.LENGTH_SHORT).show();
        //Toast.makeText(getApplicationContext(), "Socket: " + socketUtil.toString(), Toast.LENGTH_LONG).show();
    }

    /**
     * Metodo para crear los listeners de los botones
     * */
    private void crearListeners() {
        /**
         * Listener para los botones de movimiento y el claxon
         */
        touchListenerBotones = new View.OnTouchListener() {
            @Override
            public boolean onTouch(View view, MotionEvent motionEvent) {
                // modificamos el boton
                switch (motionEvent.getAction()) {
                    case MotionEvent.ACTION_DOWN:
                        view.setPressed(true);
                        break;
                    case MotionEvent.ACTION_UP:
                        view.setPressed(false);
                        view.performClick();
                        break;
                }

                // informacion para depurar
                // Toast.makeText(getApplicationContext(), "is Pressed: " + view.isPressed() + " button: " + view.getTag(), Toast.LENGTH_SHORT).show();
                // actuamos segun este el boton
                // todo meter el bloque if dentro del switch superior para que no se envien mensajes constante mente
                if (socketUtil != null){
                    switch (view.getTag().toString()){
                        case "Claxon":
                            socketUtil.emit("claxon", view.isPressed());
                            break;
                        default:
                        socketUtil.emit("movimiento", view.isPressed() ? view.getTag() : "Parar");
                    }

                }
                return true;
            }
        };// fin del listener movimiento

        /**
         * Listener para las luces, intermitentes y emergencias
         */
        touchListenerSwitches = new View.OnTouchListener() {
            @Override
            public boolean onTouch(View view, MotionEvent motionEvent) {
                // modificamos el estado del boton
                if(motionEvent.getAction()==MotionEvent.ACTION_DOWN){
                    // al presionar el boton cambiamos el estado
                    view.setPressed(!view.isPressed());
                }else if(motionEvent.getAction()==MotionEvent.ACTION_UP){
                    // al soltar el boton actuamos
                    switch (view.getTag().toString()){
                        case "Luces":
                            Toast.makeText(getApplicationContext(),"Boton: "+view.getTag().toString(), Toast.LENGTH_SHORT).show();
                            if (socketUtil != null) socketUtil.emit("luces", view.isPressed() ? "on" : "off");
                            break;
                        case "Izquierdo":
                            Toast.makeText(getApplicationContext(),"Boton: "+view.getTag().toString(), Toast.LENGTH_SHORT).show();
                            if (socketUtil != null) {
                                // desactivamos el otro intermitente
                                findViewById(R.id.btn_sig_rot_right).setPressed(false);
                                socketUtil.emit("intermitentes", view.isPressed() ? view.getTag(): "Reposo");
                            }
                            break;
                        case "Derecho":
                            Toast.makeText(getApplicationContext(),"Boton: "+view.getTag().toString(), Toast.LENGTH_SHORT).show();
                            if (socketUtil != null) {
                                findViewById(R.id.btn_sig_rot_left).setPressed(false);
                                socketUtil.emit("intermitentes", view.isPressed() ? view.getTag() : "Reposo");
                            }
                            break;
                        case "Emergencias":
                            Toast.makeText(getApplicationContext(),"Boton: "+view.getTag().toString(), Toast.LENGTH_SHORT).show();
                            if (socketUtil != null) socketUtil.emit("emergencias", view.isPressed() ? "on" : "off");
                            // encendemos los intermitentes si hay alguno activo
                            if(!view.isPressed() && (findViewById(R.id.btn_sig_rot_left).isPressed() || findViewById(R.id.btn_sig_rot_right).isPressed()) ){
                                Toast.makeText(getApplicationContext(), "Intermitentes on tras emergencias off", Toast.LENGTH_SHORT).show();
                                socketUtil.emit("intermitentes", findViewById(R.id.btn_sig_rot_left).isPressed() ? "Izquierdo" : "Derecho" , Toast.LENGTH_SHORT);
                            }
                            break;
                    }
                }
                return true;
            }
        };
    }

    /**
     * Metodos que actualizan la interfaz
     */
    private void actualizarAreaNotificaciones(final String msg) {
        //areaNotificaciones.appendText(msg+"\n");
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                areaNotificaciones.getText().append(msg + "\n");
            }
        });
    }


    // mierdas que estoy probando
    public void prueba(View vista) {
        Toast.makeText(getApplicationContext(), "view:"+vista.getTag()+" - Pressed: "+vista.isPressed(),Toast.LENGTH_SHORT).show();
    }
}
