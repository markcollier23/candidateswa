document.write("\<h1\>Please select which set of candidates you would like to research.\<\/h1\>");
assembly = document.createElement("H2");
assembly.style.top = "200px";
assembly.innerHTML = "Legislative Assembly Candidates";
document.body.appendChild(assembly);
churchlands=img("https://candidateswa.herokuapp.com/WA2021/Legislative Assembly/churchlands.png",url("https://candidateswa.herokuapp.com/WA2021/Legislative Assembly/churchlands.html"));
churchlands.style.top = "300px"
wanneroo=img("https://candidateswa.herokuapp.com/WA2021/Legislative Assembly/wanneroo.png",url("https://candidateswa.herokuapp.com/WA2021/Legislative Assembly/wanneroo.png"));
wanneroo.style.top = "600px";
council = document.createElement("H2");
council.style.top  = "700px";
council.innerHTML = "Legislative Council Candidates";
document.body.appendChild(council);
north=img("https://candidateswa.herokuapp.com/WA2021/Legislative Council/North Metro.png",url("https://candidateswa.herokuapp.com/WA2021/Legislative Council/North Metro.html"));
north.style.top = "800px";