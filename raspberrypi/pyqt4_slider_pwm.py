import sys
from PyQt4 import QtGui, QtCore
import socket
HOST = '192.168.1.109'
PORT = 50009
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)# SOCK_STREAM)
s.connect((HOST,PORT))

app = QtGui.QApplication(sys.argv)
widget = QtGui.QWidget()

widget.setGeometry(200, 100, 400, 40)
widget.setWindowTitle('Raspberry pi PWM Control')

slider = QtGui.QSlider(QtCore.Qt.Horizontal, widget)
slider.setGeometry(10, 10, 350, 30)
slider.setMinimum(1)
slider.setMaximum(1024)
slider.setValue(512)
slider.setFocusPolicy(QtCore.Qt.NoFocus)

def getValue(value):
    print value
    s.send(str(value))
widget.connect(slider, QtCore.SIGNAL('valueChanged(int)'),
        getValue)
widget.show()
sys.exit(app.exec_())
