<html>
<head>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">

<title>Welcome home!</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=.9">
	<style>
body {
	background-color: #6C5B7B;
}
</style>
</head>
	<div class="mt-5"></div>	
	<div class="jumbotron container">
	<div class="btn-toolbar d-flex justify-content-center" style="width:100%">
	<form action="/ERS/login" method="POST">
						<input type="submit" value="Home" name="button"
							class="list-group-item">
					</form>
					
									<form action="/ERS/login" method="POST">
						<input type="submit" value="Profile" name="button"
							class="list-group-item">
					</form>
					
										<form action="/ERS/login" method="POST">
						<input type="submit" value="logout" name="button"
							class="list-group-item">
					</form>
</div>

<div class="btn-toolbar d-flex justify-content-center" style="width:100%">
<form action="/ERS/login" method="POST">
						<input type="submit" value="resolved" name="button"
							class="list-group-item">
					</form>
					
														<form action="/ERS/login" method="POST">
						<input type="submit" value="users" name="button"
							class="list-group-item">
					</form>	
</div>
	
		<div class="row">
			<div class="col-8">
				<h2>
					Welcome,
					<%=session.getAttribute("username")%></h2>
			</div>
		</div>
		<table class="table table-bordered table-striped">
			<tbody id="myTable">
				<th>ID</th>
				<th>user</th>
				<th>amount</th>
				<th>status</th>
				<th>approving manager</th>
				<th>receipt</th>
			</tbody>
		</table>

		<form action="/ERS/login" method="POST">

			<label for="selectId">Reimbursement Number</label> <p id="invalid" style="color:red;"></p>
			<input
				type="number" name="selectId" id=selectId> <br> <input
				type="submit" value="decline" name="button" class="btn btn-danger" id="decline">
			<input type="submit" value="approve" name="button"
				class="btn btn-primary" id="approve">

		</form>

	</div>

	<script>

	window.onload = function() {

		  document.getElementById("approve").addEventListener("click", function(event){
			  console.log("id, status"+ statuscol.id+", "+statuscol.textContent);
			  input = document.getElementById("selectId").value;
			  console.log(input);
			  isValid = document.getElementById(input);
			  console.log(isValid)
		    if(!isValid || isValid.textContent != "pending"){
			      event.preventDefault();
			      document.getElementById("invalid").innerHTML="Invalid reimbursement number.";
		    }
			});
		  
		  document.getElementById("decline").addEventListener("click", function(event){
			  console.log("id, status"+ statuscol.id+", "+statuscol.textContent);
			  input = document.getElementById("selectId").value;
			  console.log(input);
			  isValid = document.getElementById(input);
			  console.log(isValid)
		    if(!isValid || isValid.textContent != "pending"){
			      event.preventDefault();
			      document.getElementById("invalid").innerHTML="Invalid reimbursement number.";
		    }
			});
		
		var user = '<%=session.getAttribute("info")%>';
		
		var x = new XMLHttpRequest();
		x.onreadystatechange = () => {
			//comment the if condition and try to print all different readyStates
			if((x.readyState == 4) && (x.status ==200)){
				console.log(JSON.parse(x.responseText));
				data = JSON.parse(x.responseText);
				for (i = 0; i < data.length; i++) {

					
					k=i+1;
					row = document.createElement("tr");
					idcol = document.createElement("td");
					usercol = document.createElement("td");
					amountcol = document.createElement("td");
					statuscol = document.createElement("td");
					approvercol = document.createElement("td");
					imagecol = document.createElement("td");
					statuscol.setAttribute("id", data[i].reimbursement_id);					
					
					idcol.textContent = data[i].reimbursement_id;
					usercol.textContent = data[i].username;
					amountcol.textContent = Number(data[i].amount).toFixed(2);
					statuscol.textContent = data[i].status;
					approvercol.textContent = data[i].approvingManager;
					
					if(data[i].image==0){
						imagecol.textContent = "no receipt"
					}else{
						var a = document.createElement('a');
						tn = document.createTextNode('receipt');
						a.appendChild(tn);
						a.href="javascript:window.open('"+"/ERS/images/"+k+".png"+"','mypopuptitle','width=600,height=400')"
						imagecol.appendChild(a);
					}
					
					row.appendChild(idcol);
					row.appendChild(usercol);
					row.appendChild(amountcol);
					row.appendChild(statuscol);
					row.appendChild(approvercol);
					row.appendChild(imagecol);

					document.getElementById("myTable").appendChild(row);
				} 
				
			}
		};
		x.open("get","http://localhost:8080/ERS/login/reimbursements/users/"+user);
		x.send();
	}
	</script>
</body>

</html>