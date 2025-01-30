var createError = require('http-errors');
var express = require('express');
var expressJsdocSwagger = require('express-jsdoc-swagger');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var difficultyRouter = require('./routes/routes-difficulty');
var durationRouter = require('./routes/routes-duration');
var equipmentRouter = require('./routes/routes-equipment');
var ingredientRouter = require('./routes/routes-ingredient');
var recipeRouter = require('./routes/routes-recipe');
var tagRouter = require('./routes/routes-tag');
var unitRouter = require('./routes/routes-unit');

var options = {
  info: {
    version: '1.0.0',
    title: 'Recipe Api Express',
    description: 'Recipe Api written in express.js currently pulling data from SQL Server',
  },
  filesPattern: `${__dirname}/routes/*.js`,
  swaggerUIPath: '/docs',
};

var app = express();
expressJsdocSwagger(app)(options);

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use((req, res, next) => {
    res.append('Access-Control-Allow-Origin', ['*']);
    res.append('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE');
    res.append('Access-Control-Allow-Headers', 'Content-Type');
    next();
});


app.use('/difficulty', difficultyRouter);
app.use('/duration', durationRouter);
app.use('/equipment', equipmentRouter);
app.use('/ingredient', ingredientRouter);
app.use('/recipe', recipeRouter);
app.use('/tag', tagRouter);
app.use('/unit', unitRouter)

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
