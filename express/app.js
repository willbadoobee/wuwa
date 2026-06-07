var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
<<<<<<< HEAD
=======
var authRouter = require('./routes/auth');
var equipmentRouter = require('./routes/equipment');
var ordersRouter = require('./routes/orders');
var cors = require('cors');
>>>>>>> 7036f0e (backend + update frontend & database)

var app = express();

app.use(logger('dev'));
<<<<<<< HEAD
=======
app.use(cors());
>>>>>>> 7036f0e (backend + update frontend & database)
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/users', usersRouter);
<<<<<<< HEAD
=======
app.use('/api/auth', authRouter);
app.use('/api/equipment', equipmentRouter);
app.use('/api/orders', ordersRouter);
>>>>>>> 7036f0e (backend + update frontend & database)

module.exports = app;
