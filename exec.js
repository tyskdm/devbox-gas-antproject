var container_name = WScript.Arguments(0);
var commandline = "docker exec " + container_name + " ";

for (var i = 1; i < WScript.Arguments.length; i++) {
    var argstr = WScript.Arguments(i);
    if (argstr.substr(1, 2) == ':\\') {
        var linuxpath = "";
        linuxpath = '/' + argstr.substr(0, 1).toLowerCase() + '/';
        linuxpath += argstr.substr(3).replace(/\\/g, '/');
        argstr = linuxpath;
    }
    commandline += argstr + " ";
}

var wsh = new ActiveXObject("WScript.Shell");
var exec = wsh.exec(commandline);

var str;
while (exec.Status == 0) {
    str = exec.StdOut.ReadAll();
    if (str) WScript.StdOut.WriteLine(str);
    str = exec.StdErr.ReadAll();
    if (str) WScript.StdErr.WriteLine(str);
}
str = exec.StdOut.ReadAll();
if (str) WScript.StdOut.WriteLine(str);
str = exec.StdErr.ReadAll();
if (str) WScript.StdErr.WriteLine(str);

WScript.quit(exec.ExitCode);
