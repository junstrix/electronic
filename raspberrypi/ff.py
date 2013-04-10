import sys
from PyQt4 import QtGui, QtCore
app = QtGui.QApplication(sys.argv)
widget = QtGui.QWidget()
widget.setWindowTitle("raspberry pi PWM Control")
lcd = QtGui.QLCDNumber(widget)
slider = QtGui.QSlider(QtCore.Qt.Horizontal)
vbox = QtGui.QVBoxLayout()
vbox.addWidget(lcd)
vbox.addWidget(slider)
widget.setLayout(vbox)
widget.connect(slider,  QtCore.SIGNAL('valueChanged(int)'), lcd,
                 QtCore.SLOT('display(int)'))
widget.resize(250, 150)
widget.show()
sys.exit(app.exec_())
