

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <jsp:include page="bootstrap.jsp"/>
    <style>
        @import url('https://fonts.googleapis.com/css?family=Poppins:400,500,600,700&display=swap');
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-image: linear-gradient(rgba(0,0,50,0.8),rgba(0,0,50,0.8)),url('https://fssm.umt.edu.my/wp-content/uploads/2020/04/FSSM-Building.jpg');
            background-position: center;
            background-size: cover;
            position: relative;
        }
        .container {
            width: 100%;
            display: flex;
            max-width: 1000px;
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
        }
        .wrapper {
            position: relative;
            max-width: 430px;
            width: 100%;
            background: #fff;
            padding: 34px;
            border-radius: 6px;
            box-shadow: 0 5px 10px rgba(0,0,0,0.2);
        }
        .wrapper h1 {
            position: relative;
            font-size: 30px;
            font-weight: 600;
            color: #333;
            font-weight: bolder;
        }
        .wrapper h1::before {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            height: 3px;
            width: 28px;
            border-radius: 12px;
            background: #4070f4;
        }
        .wrapper form {
            margin-top: 30px;
        }
        .input-box {
            display: flex;
            align-items: center;
            margin: 18px 0;
        }
        .input-box label {
            flex: 1;
            font-weight: 500;
            margin-right: 10px;
        }
        .input-box input {
            flex: 2;
            height: 100%;
            width: 100%;
            outline: none;
            padding: 0 15px;
            font-size: 17px;
            font-weight: 400;
            color: #333;
            border: 1.5px solid #C7BEBE;
            border-bottom-width: 2.5px;
            border-radius: 6px;
            transition: all 0.3s ease;
        }
        .input-box input:focus,
        .input-box input:valid {
            border-color: #4070f4;
        }
        .input-box.button input {
            color: #fff;
            letter-spacing: 1px;
            border: none;
            background: blue;
            cursor: pointer;
        }
        .input-box.button input:hover {
            background: #0e4bf1;
        }
        .form-group {
            position: relative;
        }
        .form-group select {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            outline: none;
            appearance: none;
            background-color: #fff;
            color: #333;
            cursor: pointer;
        }
        .form-group::after {
            content: '\25BC';
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            font-size: 18px;
            color: #555;
            pointer-events: none;
        }
        .form-group select:hover,
        .form-group select:focus {
            border-color: #007bff;
        }
        .pic {
            width: 500px;
            height: 200px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .pic img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-top-right-radius: 30px;
            border-bottom-right-radius: 15px;
            margin-left: 10%;
            margin-top: 100%;
        }
    </style>
</head>
<body>
   
    
    <div class="container">
        <div class="wrapper">
            <h1>Sign Up</h1>
            <form action="doRegisterStu.jsp" method="POST">
                <div class="input-box">
                    <label>Matric No:</label>
                    <input type="text" name="stuId" placeholder="Enter matric no" required>
                </div>
                <div class="input-box">
                    <label>Full Name:</label>
                    <input type="text" name="stuName" placeholder="Enter your full name" required>
                </div>
                <div class="input-box">
                    <label>Phone No:</label>
                    <input type="text" name="phoneNo" placeholder="Enter your Phone No" required>
                </div>
                <div class="form-group">
                    <label for="program">Reference Field:</label>
                    <select name="program">
                        <option value="option">Choose reference field</option>
                        <option value="Physical Chemistry">Physical Chemistry</option>
                        <option value="Organic Chemistry">Organic Chemistry</option>
                        <option value="Inorganic Chemistry">Inorganic Chemistry</option>
                        <option value="Material Chemistry">Material Chemistry</option>
                        <!-- Add more options as needed -->
                    </select>
                </div>
                <div class="form-group">
                    <label for="semester"> Semester:</label>
                    <select name="semester">
                        <option value ="option"> Choose semester</option>
                        <option value ="FYP I"> FYP I </option>
                        <option value ="FYP II"> FYP II </option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="courseCode">Course Code:</label>
                    <select name="courseCode">
                        <option value ="option"> Choose course code</option>
                        <option value ="CHM4982"> CHM4982(FYP I) </option>
                        <option value ="CHM4994"> CHM4994(FYP II)</option>
                    </select>
                </div>
                <div class="input-box">
                    <label>Email:</label>
                    <input type="Email" name="email" placeholder="Enter your email" required>
                </div>
                <div class="input-box">
                    <label>Password:</label>
                    <input type="password" name="password" placeholder="Enter Password" style="-webkit-text-security: disc;">
                </div>
                <div class="input-box button">
                    <input type="Submit" value="Register Now">
                </div>
                
            </form>
        </div>
        <div class="pic">
            <img src="https://cdn035.yun-img.com/static/upload/mlx/visualtoolkit/20201112181917_76399.jpg">
        </div>
    </div>
    
     <jsp:include page="footer.jsp" />
</body>
</html>
