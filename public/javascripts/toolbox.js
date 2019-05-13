function button(im,txt,func,t,l,w,h,z){
    btn = img(im);
    document.body.appendChild(btn);
    var b = {
        i:btn,
        t:textcentre(txt,btn),
        width:function(bw){
            b.i.style.width = bw+"px";
            b.t = textcentre(txt,b.i,b.t);
        },
        height:function(bh){
            b.i.style.height = bh+"px";
            b.t = textcentre(txt,b.i,b.t);
        },
        top:function(bt){
            b.i.style.top = bt+"px";
            b.t = textcentre(txt,b.i,b.t);
        },
        left:function(bl){
            b.i.style.left = bl+"px";
            b.t = textcentre(txt,b.i,b.t);
        },
        zIndex:function(bz){
            b.i.style.zIndex = bz;
            b.t.style.zIndex = bz;
        },
		caption:function(cap){
			txt = cap;
			b.t = textcentre(txt,b.i,b.t);
		},
		fun:function(f){
			b.t.setAttribute("onclick",f);
		},
		hide:function(invisible){
			b.i.style.visibility = invisible?"hidden":"visible";
			b.t.style.visibility = b.i.style.visibility;
		}
    }
    if(arguments.length>4){
        b.width(w);
        b.height(h);
        b.top(t);
        b.left(l);
        b.zIndex(z);
    }
    b.fun(func);
    return b;
}

function img(source,func){
	var i = new Image();
	i.src = source;
	if(arguments.length>1)
		i.setAttribute("onclick",func);
	i.style.position = "absolute";
    i.style.zIndex = 2;
	return i;
}
function url(hlink){
	return "window.open('"+hlink+"')";
}
function textcentre(txt,node,d){
	if(arguments.length<3)d = document.createElement("DIV");
	d.style.position = "absolute";
	d.style.zIndex = node.style.zIndex + 1;
	d.style.height = node.style.height;
	d.style.width = node.style.width;
	d.style.top = node.style.top;
	d.style.left = node.style.left;
	d.style.lineHeight = d.style.height;
	d.style.textAlign = "center";
	d.style.display = "table-cell";
	d.style.verticalAlign = "middle"
	d.innerHTML = txt;
	node.parentNode.appendChild(d);
	return d;
}