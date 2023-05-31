import java.io.File;
import java.util.Calendar;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;

public aspect Log {
   //sing up
    File file = new File("Register.txt");
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Calendar cal = Calendar.getInstance();

    pointcut signUpSuccess(User user, Person person) : call(void successfulSignUp(User, Person)) && args(user, person);
    //Aspecto: Deben hacer los puntos de cortes (pointcut) para crear un log con los tipos de transacciones realizadas.
    after(User user, Person person) returning : signUpSuccess(user, person) {
    	System.out.println("**** User created ****");
    	try {
            FileWriter fileWriter = new FileWriter(file, true);
            fileWriter.write("Usuario registrado: [");
            fileWriter.write(user.toString());
            fileWriter.write("]  ");
            fileWriter.write("Fecha: [");
            fileWriter.write(dateFormat.format(cal.getTime()));
            fileWriter.write("]  ");
            fileWriter.close(); 
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}


public aspect Logger {
    // log in log out
	File file = new File("Log.txt");
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Calendar cal = Calendar.getInstance();
    pointcut logInOutSuccess(User user) : call(void effectiveLogIn(User)) && args(user);
    
    after(User user) returning : logInOutSuccess(user) {
        
        System.out.println(user.getNickname() + " have logged in successfully");
        try {
            FileWriter fileWriter = new FileWriter(file, true);
            fileWriter.write("Usuario registrado: [");
            fileWriter.write(user.getNickname());
            fileWriter.write("]  ");
            fileWriter.write("Fecha: [");
            fileWriter.write(dateFormat.format(cal.getTime()));
            fileWriter.write("]  ");
            fileWriter.close(); 
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

   
    
    
}