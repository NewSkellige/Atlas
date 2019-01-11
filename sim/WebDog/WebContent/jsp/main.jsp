<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="../css/common.css" rel="stylesheet" type="text/css">
<title>WebDog</title>
<script src="../js/three.js" type="text/javascript" charset="utf-8"></script>
<script src="../js/ObjectLoader.js" type="text/javascript" charset="utf-8"></script>
<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
	$(function() {
		$('.cleftH4').click(function() {
			//切换标签样式
			$(this).addClass('cleftH4On').siblings().removeClass('cleftH4On');
			//切换div显示隐藏
			document.getElementsByClassName("cleftUl").item($(this).index()/2).style.display = "block";
		});
	});
</script>

<script type="text/javascript">
	$(function() {
		$('.cleft ul li').click(function() {
			//切换标签样式
			$(this).addClass('cleft ul li.on').siblings().removeClass('cleft ul li.on');
			//切换div显示隐藏
			//document.getElementsByClassName("cleftUl").item($(this).index()/2).style.display = "block";
		});
	});
</script>
</head>
<body>
<!-- 头部 -->
<div class = "header">
	<div class = "hleft">
		<span class = "head-icon">WebDog</span>
	</div>
	<div class ="hcenter">
		<ul>
			<li class = "on">模型环境</li>
			<li>仿真结果</li>
			<li>其他鬼东西</li>
		</ul>
	</div>
	<div class ="hright">
	
	</div>
</div>
<!-- 内容部分 -->
<div class = "center">
	<div class = "cleft">
		<h4 class = "cleftH4">模型放置</h4>
		<ul class = "cleftUl" style = "display:none;">
			<li class = "cleftLi">正方体</li>
			<li class = "cleftLi">球体</li>
			<li class = "cleftLi">锥体</li>
			<li class = "cleftLi">导入</li>
		</ul>
		<h4 class = "cleftH4">参数设置</h4>
		<ul  class = "cleftUl" style = "display:none;">
			<li class = "cleftLi">速度:<input type = "text"/></li>
			<li class = "cleftLi">方向:<input type = "text"/></li>
			<li class = "cleftLi">次数:<input type = "text"/></li>
			<li class = "cleftLi"><input type = "submit" value = "开始"/></li>
		</ul>
	</div>
	<div class ="cright">
		<div id="WebGL" style = "width:100%;height:100%;">
		</div>
		<script>
			
        	var scene = new THREE.Scene();
        
        	var camera = new THREE.PerspectiveCamera(75, window.innerWidth/window.innerHeight, 0.1, 1000);
        
        	var renderer = new THREE.WebGLRenderer();
        	
        	var width = document.getElementById("WebGL").clientWidth;//获取画布「canvas3d」的宽
            var height = document.getElementById("WebGL").clientHeight;//获取画布「canvas3d」的高
        
        	renderer.setSize(width, height);
        
        	document.getElementById("WebGL").appendChild(renderer.domElement);
        	var geometry = new THREE.CubeGeometry(1,1,1);
        	var material = new THREE.MeshBasicMaterial({color: 0x00ff00});
        	var cube = new THREE.Mesh(geometry, material); 
        	//scene.add(cube);
        	
        	var light=new THREE.PointLight(0xff0000);
        	light.position.set(300,400,200);//光源的位置
       		scene.add(light);//将光源加入到场景中
  			scene.add(new THREE.AmbientLight(0x333333));//添加环境光  让背景 亮一点
        	
  			var model;
        	var loader = new THREE.OBJLoader();
        	loader.load( "../model/testobj.obj", 
        		function ( object ) {
        			model = object; 
        			scene.add( object );
        		}
        	);
        	
        	camera.position.z = 5;
        	function render() {
            	requestAnimationFrame(render);
            	model.rotation.x += 0.02;
            	model.rotation.y += 0.02;
            	renderer.render(scene, camera);
        	}
        	render();        	
    	</script>
    	<!-- <script type="text/javascript">
      		$(function() {
        //添加窗口尺寸改变响应监听
        		$(window).resize(resizeCanvas);
        //页面加载后先设置一下canvas大小
       		 	resizeCanvas();
      		});
 
      	//窗口尺寸改变响应（修改canvas大小）
     	 	function resizeCanvas() {
     	 		alert("hello");
        		$('#WebGL canvas').attr("width", $("#WebGL").width);
        		$('#WebGL canvas').attr("height", $("#WebGL").height);
      		};
    	</script>
    	 -->
    	
	</div>
</div>
</body>
</html>