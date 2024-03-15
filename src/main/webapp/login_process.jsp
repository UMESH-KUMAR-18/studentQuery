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
    String password = request.getParameter("password");
    
    // Database connection and update
    Connection connection = null;
    

    // Database connection and insertion
    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection to the database

		connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);


        // Prepare SQL statement for insertion
        String sql = "INSERT INTO test (username, lpassword) VALUES (?,?)";
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, username);
        preparedStatement.setString(2, password);

        // Execute the SQL statement
        int rowsAffected = preparedStatement.executeUpdate();

        // Close resources
        preparedStatement.close();
        connection.close();

        // Redirect to a success page or provide a success message
        

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

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
