import 'dart:ffi';
import 'package:toast/toast.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'pages/homePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _nameCrtl = TextEditingController();
  TextEditingController _passwordCrtl = TextEditingController();
  // bool _showPassword = false;
  String _username = '', _password = '';
  @override
  // TODO: implement widget
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      // 头部
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('登录'),
        centerTitle: true,
        // brightness:Brightness.dark,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/begin_bg.png"), // 这里设置背景图片
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _getRoundImage('assets/images/logo.jpg', 100.0), //头像logo
              SizedBox(
                height: 45,
              ),
              _getUsernameInput(),
              _getPasswordInput(),
              SizedBox(
                height: 10,
              ),
              _getLoginButton(),
              SizedBox(
                height: 10,
              ),
              buildRegisterText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getLoginButton() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor:
              MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
        ),
        child: Text('登录'),
        onPressed: () {
          onLogin(context);
          // print(
          //     'Login :username = ${_username.trim()},password = ${_password.trim()}');
        },
      ),
    );
  }

  Widget _getInputTextField(
    TextInputType keyboardType, {
    // required FocusNode focusNode,
    controller = TextEditingController,
    onChanged = Function,
    required InputDecoration decoration,
    bool obscureText = false,
    height = 50.0,
  }) {
    return Container(
      height: height,
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextField(
            keyboardType: keyboardType,
            // focusNode: focusNode,
            obscureText: obscureText,
            controller: controller,
            decoration: decoration,
            onChanged: onChanged,
          ),
          Divider(
            height: 1.0,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  Widget _getUsernameInput() {
    return _getInputTextField(TextInputType.number,
        controller: _nameCrtl,
        decoration: InputDecoration(
          hintText: "手机号",
          icon: const Icon(
            Icons.mobile_friendly_rounded,
            size: 20.0,
          ),
          border: InputBorder.none,
          suffixIcon: GestureDetector(
            child: Offstage(
              child: Icon(Icons.clear),
              offstage: _username == '',
            ),
            // 点击清除文本框内容
            onTap: () {
              setState(() {
                _username = '';
                _nameCrtl.clear();
              });
            },
          ),
        ),
        // 使用onChanged完成双向绑定
        onChanged: (value) {
      setState(() {
        _username = value;
      });
    });
  }

  Widget _getRoundImage(String imageName, double size) {
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(size / 2)),
      ),
      child: Image.asset(
        imageName,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget _getPasswordInput() {
    return _getInputTextField(TextInputType.text,
        obscureText: true,
        controller: _passwordCrtl,
        decoration: InputDecoration(
          hintText: "输入密码",
          icon: Icon(
            Icons.lock_open,
            size: 20.0,
          ),
          suffixIcon: GestureDetector(
            child: Offstage(
              child: Icon(Icons.clear),
              offstage: _password == '',
            ),
            // 点击清除文本框内容
            onTap: () {
              setState(() {
                _password = '';
                _passwordCrtl.clear();
              });
            },
          ),
          border: InputBorder.none,
        ), onChanged: (value) {
      setState(() {
        _password = value;
      });
    });
  }

  Widget buildRegisterText(context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('没有账号?'),
            GestureDetector(
              child: const Text('点击注册', style: TextStyle(color: Colors.green)),
              onTap: () {
                // 这里进入注册界面
                print("点击注册");
              },
            )
          ],
        ),
      ),
    );
  }

  void onLogin(BuildContext context) {
    if (_nameCrtl.text != null &&
        _passwordCrtl.text != null &&
        _passwordCrtl.text.length >= 6 &&
        _nameCrtl.text.length == 11) {
      debugPrint("成功登录！");
      Navigator.of(context).pushAndRemoveUntil(
          (MaterialPageRoute(
            builder: (context) => HomePage(),
          )),
          (route) => route == null);
    } else {
      // Fluttertoast.showToast(
      //     msg: "请输入正确的手机号和密码！",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.black45,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
      // Toast.show('请输入正确的手机号和密码！');
      Toast.show("请输入正确的手机号和密码！",
          duration: Toast.lengthShort, gravity: Toast.bottom);
    }
  }
}
