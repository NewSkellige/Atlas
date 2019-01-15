<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="../css/common.css" rel="stylesheet" type="text/css">
<title>WebDog</title>
<script src="../js/build/three.js" type="text/javascript" charset="utf-8"></script>
<script src="../js/STLLoader.js" type="text/javascript" charset="utf-8"></script>
<script src="../js/examples/js/loaders/ColladaLoader.js" type="text/javascript" charset="utf-8"></script>
<script src="../js/examples/js/loaders/collada/Animation.js"></script>
<script src="../js/examples/js/loaders/collada/AnimationHandler.js"></script>
<script src="../js/examples/js/loaders/collada/KeyFrameAnimation.js"></script>
<script src="../js/Inflate.min.js" type="text/javascript" charset="utf-8"></script>
<script src="../js/examples/js/libs/stats.min.js"></script>
<script src="../js/examples/js/controls/OrbitControls.js"></script>
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
			<li class = "cleftLi" >速度:<input type = "text" id = "speed" value = "2"/></li>
			<li class = "cleftLi">方向:<input type = "text"  id = "direction"/></li>
			<li class = "cleftLi" >次数:<input type = "text" id = "num"/></li>
			<li class = "cleftLi"><input type = "submit" value = "开始"/></li>
		</ul>
	</div>
	<div class ="cright">
		<div id="WebGL" style = "width:100%;height:100%;">
		</div>
		<script>
			
			var scene = new THREE.Scene();
			scene.background = new THREE.Color( 0xa0a0a0 );
			scene.fog = new THREE.Fog( 0xa0a0a0, 200, 1000 );

			var light = new THREE.HemisphereLight( 0xffffff, 0x444444 );
			light.position.set( 0, 200, 0 );
			scene.add( light );

			light = new THREE.DirectionalLight( 0xffffff );
			light.position.set( 0, 200, 100 );
			light.castShadow = true;
			light.shadow.camera.top = 180;
			light.shadow.camera.bottom = - 100;
			light.shadow.camera.left = - 120;
			light.shadow.camera.right = 120;
			scene.add( light );
        
        	var camera = new THREE.PerspectiveCamera(75, window.innerWidth/window.innerHeight, 0.1, 1000);
        	camera.position.set( 0, 20, 20 );
        	camera.lookAt(0,0,0);
        
        	var renderer = new THREE.WebGLRenderer();
        	
        	var width = document.getElementById("WebGL").clientWidth;//获取画布「canvas3d」的宽
            var height = document.getElementById("WebGL").clientHeight;//获取画布「canvas3d」的高
        
        	renderer.setSize(width, height);
        
        	document.getElementById("WebGL").appendChild(renderer.domElement);
			
  			/*
  			var loader = new THREE.STLLoader();
  			loader.load( '../model/sphere.stl', function ( geometry ) {
					material = new THREE.MeshPhongMaterial( { color: 0xff5533, specular: 0x111111, shininess: 200 } );
					mesh = new THREE.Mesh( geometry, material );
					model = mesh;
					scene.add(mesh);
  			});
  			*/
  			
  			var loader = new THREE.ColladaLoader();
  			loader.options.convertUpAxis = true;
			loader.load( '../model/avatar.dae', function ( object) {
				dae = object.scene;
				dae.scale.multiplyScalar(200);
				dae.updateMatrix();
				scene.add(dae);
			} );
			
						
			var controls = new THREE.OrbitControls( camera, renderer.domElement );
			controls.target.set( 0, 12, 0 );
			camera.position.set( 2, 18, 28 );
			controls.update();
			
									
			function onWindowResize() {
				camera.aspect = window.innerWidth / window.innerHeight;
				camera.updateProjectionMatrix();
				renderer.setSize( window.innerWidth, window.innerHeight );
			}
			
			$(function() {
				$('.cleftH4').click(function() {
					var loader = new THREE.STLLoader();
		  			loader.load( '../model/sphere.stl', function ( geometry ) {
		  				var material = new THREE.MeshPhongMaterial( { ambient: 0xff5533, color: 0xff5533, specular: 0x111111, shininess: 200 } );
                        var mesh = new THREE.Mesh( geometry, material );
						scene.add(mesh);
		  			});
				});
			});

			window.addEventListener( 'resize', onWindowResize, false );	
			
        	function render() {
        		 scene.traverse(function(child){
    		        if (child instanceof THREE.SkinnedMesh){
    		        	var s = document.getElementById("speed").value;
    		        	for( var i = 0;i < child.skeleton.bones.length;i+=1){
    		        		child.skeleton.bones[i].rotation.x += s/100 ;
    		        		child.skeleton.bones[i].rotation.y += s/100 ;
    		        		child.skeleton.bones[i].rotation.z += s/100 ;
    		        	}
    		        }
    		        else if  (child instanceof THREE.SkeletonHelper){
    		            child.update();
    		        }
    			}); 
            	requestAnimationFrame(render);
            	renderer.render(scene, camera);
        	}
        	render();         	
        </script>    	
	</div>
</div>
</body>
</html>