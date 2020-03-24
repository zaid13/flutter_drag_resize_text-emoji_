
import "package:flutter/material.dart";
void main(){


	return runApp(MyApp());}


class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			home: Scaffold(
				appBar: AppBar(
					title: Text("Drag app"),
				),
				body: HomePage(),
			),
		);
	}
}

class HomePage extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return _HomePageState();
	}
}

class _HomePageState extends State<HomePage> {

	List<Widget> ls  = [];
	var text;
var texter;
	double width = 100.0, height = 100.0;
	Offset position ;

	@override
	void initState() {
		super.initState();
		position = Offset(100.0, 100.0);  //iniitial posoition of new texts 


ls.add(	textwid("custom" , 2.0 , position),);//just copy  and paste this to add more texts

	}

	@override
	Widget build(BuildContext context) {
		return Column(
		  children: <Widget>[
		  	RaisedButton(
onPressed: (){
	setState(() {

		ls.add(	textwid("custom" , 2.0 , position),);


	});

},
					child: Text("Add text"),

				),
		    SafeArea(
		      child: Container(
						
						///todo hard coded values can cause over flow
	
		    		width: MediaQuery.of(context).size.width,
		        height: MediaQuery.of(context).size.height-200,
		        child: Stack(
		        	children:ls
		        ),
		      ),
		    ),
		  ],
		);
	}


}

class textwid extends StatefulWidget {
	var text;

	var size;
	double width = 100.0, height = 100.0;
	Offset position ;
	textwid(this.text , this.size,this.position);

  @override
  _textwidState createState() => _textwidState();
}

class _textwidState extends State<textwid> {


  @override
  Widget build(BuildContext context) {
    return 				Positioned(
			left: widget.position.dx,
			top: widget.position.dy - widget.height + 20,
			child: Draggable(
				child: Container(
					child: Material(
						color: Colors.transparent,
						child: FlatButton(
							onPressed: (){{
								Navigator.of(context).push(PageRouteBuilder(
										opaque: false,
										pageBuilder: (BuildContext context, _, __) =>
												RedeemConfirmationScreen(this,widget.text,widget.size)));
							}
							},
							onLongPress: (){


							},
							child: Container(
								child: Text(widget.text, style:TextStyle(fontSize: widget.size*10.0 ,color: Colors.purple),),
								color: Colors.transparent,
		
							),
						),
					),
				),
				feedback: Container(
					child: Material(
						color: Colors.transparent,
						child: FlatButton(
							onPressed: (){{
								Navigator.of(context).push(PageRouteBuilder(
										opaque: false,
										pageBuilder: (BuildContext context, _, __) =>
												RedeemConfirmationScreen(this,widget.text,widget.size)));
							}
							},
							onLongPress: (){


							},
							child: Container(
								child: Text(widget.text, style:TextStyle(fontSize: widget.size*10.0 ,color: Colors.purple),),
								color: Colors.blue,
								//	width: width,
								//		height: height,

							),
						),
					),						),
				childWhenDragging: Container(),
				onDraggableCanceled: (Velocity velocity, Offset offset){
					setState(() => widget.position = offset);
				},
			),
		);
  }
}


class RedeemConfirmationScreen extends StatefulWidget {
	_textwidState parent;
	String text;
	double _value;
	RedeemConfirmationScreen(this.parent,this.text,this._value);

  @override
  _RedeemConfirmationScreenState createState() => _RedeemConfirmationScreenState();
}

class _RedeemConfirmationScreenState extends State<RedeemConfirmationScreen> {
	TextEditingController _controller = new TextEditingController();

	@override
	Widget build(BuildContext context) {
		_controller.text = widget.text;

		return Scaffold(
				backgroundColor: Colors.white.withOpacity(0.85), // th
			body: Material(
			  child: Column(
			    children: <Widget>[
			      TextField(
					controller: _controller,
			      ),
						Slider(
								value: widget._value,
								min: 1.0,
								max: 10.0,
								divisions: 10,
								activeColor: Colors.red,
								inactiveColor: Colors.black,
								label: 'Set a value',
								onChanged: (double newValue) {
									setState(() {
										widget._value = newValue;
										print(newValue);

									});
								},
								semanticFormatterCallback: (double newValue) {
									return '${newValue.round()} dollars';
								}
						),
						FlatButton(
							onPressed: (){
								this.widget.parent.setState(() {

									this.widget.parent.widget.text  = _controller.text;
									this.widget.parent.widget.size = widget._value;
									print("value of parent changed");
								});



							Navigator.pop(context);
							},
							child: Text("OK"),

						),
			    ],
			  ),
			),//
		);
	}
}
