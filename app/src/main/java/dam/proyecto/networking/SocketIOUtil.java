package dam.proyecto.networking;

import java.net.URISyntaxException;

import io.socket.client.IO;
import io.socket.client.Socket;
import io.socket.emitter.Emitter.Listener;

public class SocketIOUtil {
    private Socket socket;
    private String fullHost;
    private String host;
    private String port;

    // constructor de la clase
    public SocketIOUtil(String host, String port) {
        this.host = host;
        this.port = port;
        this.fullHost = "http://"+this.host+":"+this.port;
        try {
            socket = IO.socket(fullHost);
            manejadorMensajes();
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
    }


    // conectar
    public void connect() {
        socket.connect();
    }

    // enviar mensajes
    public void send(Object args) {
        socket.send(args);
    }

    /**
     * TODO arreglar este metodo para que sea seguro y chachi
     * @return false si no existe el socket
     * */
    public boolean emit(String event,Object... args) {
        if(socket!=null) {
            socket.emit(event, args);
            return true;
        }else{
            return false;
        }
    }

    // ejemplo de como recibir mensajes
    public void manejadorMensajes() {
        socket.on(Socket.EVENT_MESSAGE, new Listener() {
            @Override
            public void call(Object... args) {
                for(int i=0;i<args.length;i++) {
                    System.out.println("hola: "+args[i]);
                }
            }
        });
    }
    // para usar el socket desde la interfaz
    public Socket getSocket() {
        return this.socket;
    }

    // cerrar socket
    public void close() {
        if(this.socket.connected()) {
            this.socket.disconnect();
        }
        this.socket.close();
        this.socket=null;
    }


    /**
     * A�adiendo cosas nuevas
     * */
    // saber si se puede cerrar el socket
    public boolean isCloseable() {
        // TODO: hacer algo con esto
        return true;
    }

}
