using System;
using Microsoft.Data.SqlClient;
using Dapper;

// 1. Definiera anslutningssträngen till din Docker-instans
string connectionString = "Server=172.17.0.2,1433;Database=TestDb;User Id=sa;Password=qwerty123456!;TrustServerCertificate=True;";

Console.WriteLine("Ansluter till SQL Server...");

try
{
    using (var connection = new SqlConnection(connectionString))
    {

        // 3. Hämta strängen med en SQL-fråga via Dapper
        string sqlQuery = "SELECT TOP 1 Innehall FROM Meddelanden";
        string resultat = connection.QueryFirstOrDefault<string>(sqlQuery);

        // 4. Skriv ut resultatet på skärmen
        Console.ForegroundColor = ConsoleColor.Green;
        Console.WriteLine($"\nFramgång! Hämtad sträng: \"{resultat}\"");
        Console.ResetColor();
    }
}
catch (Exception ex)
{
    Console.ForegroundColor = ConsoleColor.Red;
    Console.WriteLine($"\nEtt fel uppstod: {ex.Message}");
    Console.ResetColor();
}
