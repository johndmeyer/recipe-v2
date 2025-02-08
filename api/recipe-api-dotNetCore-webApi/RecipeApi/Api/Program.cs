using Data;
using Logic;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddScoped<ILogicDifficulty, LogicDifficulty>();
builder.Services.AddScoped<ILogicDuration, LogicDuration>();
builder.Services.AddScoped<ILogicEquipment, LogicEquipment>();
builder.Services.AddScoped<ILogicIngredient, LogicIngredient>();
builder.Services.AddScoped<ILogicRecipe, LogicRecipe>();
builder.Services.AddScoped<ILogicTag, LogicTag>();
builder.Services.AddScoped<ILogicUnit, LogicUnit>();

builder.Services.AddScoped<IDataDifficulty, DataDifficulty>();
builder.Services.AddScoped<IDataDuration, DataDuration>();
builder.Services.AddScoped<IDataEquipment, DataEquipment>();
builder.Services.AddScoped<IDataIngredient, DataIngredient>();
builder.Services.AddScoped<IDataRecipe, DataRecipe>();
builder.Services.AddScoped<IDataTag, DataTag>();
builder.Services.AddScoped<IDataUnit, DataUnit>();

builder.Services.AddScoped<IDapperDbConnection, DapperDbConnection>();

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddCors();

var app = builder.Build();

// Configure the HTTP request pipeline.
app.UseSwagger();
app.UseSwaggerUI(x =>
{
    x.DefaultModelsExpandDepth(-1);
});

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.UseCors(options =>
{
    options
        .AllowAnyOrigin()
        .AllowAnyMethod()
        .AllowAnyHeader();
});

app.Run();
