<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="" %>

<%
    // Database connection details
    String JDBC_URL = "jdbc:mysql://localhost:3306/studentquery";
    String JDBC_USERNAME = "root";
    String JDBC_PASSWORD = "Unknown@420";

    // Retrieve username and password from signup.jsp form
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String cPassword = request.getParameter("cPassword");
    
    // Database connection and update
    Connection connection = null;
    

    // Database connection and insertion
    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection to the database
		connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
		
        //retriving the email status
        String checkEmailQuery = "SELECT COUNT(*) FROM signup WHERE email=?";
        PreparedStatement preparedStatement3 = connection.prepareStatement(checkEmailQuery);
        preparedStatement3.setString(1, email);
        ResultSet resultSet = preparedStatement3.executeQuery();
        
        if (resultSet.next()) {
            int count = resultSet.getInt(1);
            if (count > 0) {
                // Email already exists in the database, handle accordingly (e.g., display error message)
                // For example, you can redirect back to signup.jsp with an error message
                /* response.sendRedirect("NewFile.html");
                return; // Exit the script */
            	%>
                <script type="text/javascript">
                    alert("Email is already registered!");
                    window.history.back(); // Go back to the previous page (signup.jsp)
                </script>
			<%
                return; // Exit the script
            }
        }
        
        // Prepare SQL statement for insertion
      
        String sql = "INSERT INTO signup (username,email,Passowrd) VALUES (?,?,?)";
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, username);
        preparedStatement.setString(2, email);
        preparedStatement.setString(3, cPassword);

        // Execute the SQL statement
        int rowsAffected = preparedStatement.executeUpdate();
        
        //ading the user int the login table
        String sql1 = "INSERT INTO login (username,Passowrd) VALUES (?,?)";
        PreparedStatement preparedStatement1 = connection.prepareStatement(sql1);
        preparedStatement1.setString(1, username);
        preparedStatement1.setString(2, password);

        // Execute the SQL statement
        int rowsAffected1 = preparedStatement1.executeUpdate();

        // Close resources
        preparedStatement.close();
        connection.close();

        // Redirect to a success page or provide a success message
        response.sendRedirect("index.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        // Redirect to an error page or display an error message
        
    } finally {
        // Close connection
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
