using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FutebolAPI.Migrations
{
    /// <inheritdoc />
    public partial class AddAuthModels : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "DimClube",
                columns: table => new
                {
                    TimeID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Nome = table.Column<string>(type: "nvarchar(45)", maxLength: 45, nullable: false),
                    Titulos = table.Column<int>(type: "int", nullable: false),
                    Participacoes = table.Column<int>(type: "int", nullable: false),
                    Fundacao = table.Column<DateOnly>(type: "date", nullable: false),
                    Sede = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    Escudo = table.Column<string>(type: "nvarchar(1000)", maxLength: 1000, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__DimClube__E04ED96701F744D7", x => x.TimeID);
                });

            migrationBuilder.CreateTable(
                name: "DimData",
                columns: table => new
                {
                    DataID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Data = table.Column<DateOnly>(type: "date", nullable: true),
                    Ano = table.Column<int>(type: "int", nullable: true),
                    Mes = table.Column<int>(type: "int", nullable: true),
                    Dia = table.Column<int>(type: "int", nullable: true),
                    DiaSemana = table.Column<string>(type: "char(3)", unicode: false, fixedLength: true, maxLength: 3, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__DimData__9D05305DD7FE0131", x => x.DataID);
                });

            migrationBuilder.CreateTable(
                name: "DimEstadio",
                columns: table => new
                {
                    EstadioID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Nome = table.Column<string>(type: "nvarchar(45)", maxLength: 45, nullable: true),
                    Capacidade = table.Column<int>(type: "int", nullable: true),
                    Cidade = table.Column<string>(type: "nvarchar(45)", maxLength: 45, nullable: true),
                    Latitude = table.Column<double>(type: "float", nullable: true),
                    Longitude = table.Column<double>(type: "float", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__DimEstad__CC2D0FD8AB4B33EF", x => x.EstadioID);
                });

            migrationBuilder.CreateTable(
                name: "DimJuiz",
                columns: table => new
                {
                    JuizID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Nome = table.Column<string>(type: "nvarchar(45)", maxLength: 45, nullable: true),
                    Nivel = table.Column<string>(type: "nvarchar(45)", maxLength: 45, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__DimJuiz__A39816900826A564", x => x.JuizID);
                });

            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Username = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Email = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    PasswordHash = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Role = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    IsActive = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "DimJogador",
                columns: table => new
                {
                    JogadorID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Nome = table.Column<string>(type: "nvarchar(45)", maxLength: 45, nullable: true),
                    Posicao = table.Column<string>(type: "nvarchar(45)", maxLength: 45, nullable: true),
                    Nascimento = table.Column<DateOnly>(type: "date", nullable: true),
                    TimeID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__DimJogad__E3B690734503BF7E", x => x.JogadorID);
                    table.ForeignKey(
                        name: "FK__DimJogado__TimeI__3E52440B",
                        column: x => x.TimeID,
                        principalTable: "DimClube",
                        principalColumn: "TimeID");
                });

            migrationBuilder.CreateTable(
                name: "fatoclassificacao",
                columns: table => new
                {
                    RodadaID = table.Column<int>(type: "int", nullable: false),
                    TimeID = table.Column<int>(type: "int", nullable: false),
                    Pontos = table.Column<int>(type: "int", nullable: true),
                    Jogos = table.Column<int>(type: "int", nullable: true),
                    Vitorias = table.Column<int>(type: "int", nullable: true),
                    Empates = table.Column<int>(type: "int", nullable: true),
                    Derrotas = table.Column<int>(type: "int", nullable: true),
                    GolsPro = table.Column<int>(type: "int", nullable: true),
                    GolsContra = table.Column<int>(type: "int", nullable: true),
                    Saldo = table.Column<int>(type: "int", nullable: true, computedColumnSql: "([GolsPro]-[GolsContra])", stored: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__fatoclas__C452F29F67EE04B6", x => new { x.RodadaID, x.TimeID });
                    table.ForeignKey(
                        name: "FK__fatoclass__TimeI__5629CD9C",
                        column: x => x.TimeID,
                        principalTable: "DimClube",
                        principalColumn: "TimeID");
                });

            migrationBuilder.CreateTable(
                name: "fatopartida",
                columns: table => new
                {
                    PartidaID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DataID = table.Column<int>(type: "int", nullable: false),
                    EstadioID = table.Column<int>(type: "int", nullable: false),
                    JuizID = table.Column<int>(type: "int", nullable: false),
                    Publico = table.Column<int>(type: "int", nullable: true),
                    Renda = table.Column<decimal>(type: "decimal(10,2)", nullable: true),
                    Resultado = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__fatopart__E63E1FC34600D184", x => x.PartidaID);
                    table.ForeignKey(
                        name: "FK__fatoparti__DataI__46E78A0C",
                        column: x => x.DataID,
                        principalTable: "DimData",
                        principalColumn: "DataID");
                    table.ForeignKey(
                        name: "FK__fatoparti__Estad__47DBAE45",
                        column: x => x.EstadioID,
                        principalTable: "DimEstadio",
                        principalColumn: "EstadioID");
                    table.ForeignKey(
                        name: "FK__fatoparti__JuizI__48CFD27E",
                        column: x => x.JuizID,
                        principalTable: "DimJuiz",
                        principalColumn: "JuizID");
                });

            migrationBuilder.CreateTable(
                name: "RefreshTokens",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    UserId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Token = table.Column<string>(type: "nvarchar(128)", maxLength: 128, nullable: false),
                    ExpiresAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    IsRevoked = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RefreshTokens", x => x.Id);
                    table.ForeignKey(
                        name: "FK_RefreshTokens_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "AggArtilharia",
                columns: table => new
                {
                    JogadorID = table.Column<int>(type: "int", nullable: false),
                    Gols = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__AggArtil__E3B690731349D8CE", x => x.JogadorID);
                    table.ForeignKey(
                        name: "FK__AggArtilh__Jogad__412EB0B6",
                        column: x => x.JogadorID,
                        principalTable: "DimJogador",
                        principalColumn: "JogadorID");
                });

            migrationBuilder.CreateTable(
                name: "fatocartao",
                columns: table => new
                {
                    CartaoID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PartidaID = table.Column<int>(type: "int", nullable: false),
                    JogadorID = table.Column<int>(type: "int", nullable: false),
                    TimeID = table.Column<int>(type: "int", nullable: false),
                    Minuto = table.Column<int>(type: "int", nullable: true),
                    Tempo = table.Column<int>(type: "int", nullable: true),
                    Cor = table.Column<string>(type: "char(1)", unicode: false, fixedLength: true, maxLength: 1, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__fatocart__91510D018CF402E4", x => x.CartaoID);
                    table.ForeignKey(
                        name: "FK__fatocarta__Jogad__52593CB8",
                        column: x => x.JogadorID,
                        principalTable: "DimJogador",
                        principalColumn: "JogadorID");
                    table.ForeignKey(
                        name: "FK__fatocarta__Parti__5165187F",
                        column: x => x.PartidaID,
                        principalTable: "fatopartida",
                        principalColumn: "PartidaID");
                    table.ForeignKey(
                        name: "FK__fatocarta__TimeI__534D60F1",
                        column: x => x.TimeID,
                        principalTable: "DimClube",
                        principalColumn: "TimeID");
                });

            migrationBuilder.CreateTable(
                name: "fatogol",
                columns: table => new
                {
                    GolID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PartidaID = table.Column<int>(type: "int", nullable: false),
                    JogadorID = table.Column<int>(type: "int", nullable: false),
                    TimeID = table.Column<int>(type: "int", nullable: true),
                    Minuto = table.Column<int>(type: "int", nullable: true),
                    Tempo = table.Column<int>(type: "int", nullable: true),
                    GOLCONTRA = table.Column<int>(type: "int", nullable: true, defaultValue: 0)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__fatogol__E344E4C011E39039", x => x.GolID);
                    table.ForeignKey(
                        name: "FK__fatogol__Jogador__5BE2A6F2",
                        column: x => x.JogadorID,
                        principalTable: "DimJogador",
                        principalColumn: "JogadorID");
                    table.ForeignKey(
                        name: "FK__fatogol__Partida__5AEE82B9",
                        column: x => x.PartidaID,
                        principalTable: "fatopartida",
                        principalColumn: "PartidaID");
                    table.ForeignKey(
                        name: "FK__fatogol__TimeID__5CD6CB2B",
                        column: x => x.TimeID,
                        principalTable: "DimClube",
                        principalColumn: "TimeID");
                });

            migrationBuilder.CreateTable(
                name: "PontePartidaTime",
                columns: table => new
                {
                    TIMEID = table.Column<int>(type: "int", nullable: false),
                    PARTIDAID = table.Column<int>(type: "int", nullable: false),
                    PosseDeBola = table.Column<int>(type: "int", nullable: true),
                    Escanteios = table.Column<int>(type: "int", nullable: true),
                    ChutesAGol = table.Column<int>(type: "int", nullable: true),
                    Impedimentos = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__PontePar__823FDF50538ABE16", x => new { x.TIMEID, x.PARTIDAID });
                    table.ForeignKey(
                        name: "FK__PontePart__PARTI__4CA06362",
                        column: x => x.PARTIDAID,
                        principalTable: "fatopartida",
                        principalColumn: "PartidaID");
                    table.ForeignKey(
                        name: "FK__PontePart__TIMEI__4BAC3F29",
                        column: x => x.TIMEID,
                        principalTable: "DimClube",
                        principalColumn: "TimeID");
                });

            migrationBuilder.CreateIndex(
                name: "IX_DimJogador_TimeID",
                table: "DimJogador",
                column: "TimeID");

            migrationBuilder.CreateIndex(
                name: "IX_fatocartao_JogadorID",
                table: "fatocartao",
                column: "JogadorID");

            migrationBuilder.CreateIndex(
                name: "IX_fatocartao_PartidaID",
                table: "fatocartao",
                column: "PartidaID");

            migrationBuilder.CreateIndex(
                name: "IX_fatocartao_TimeID",
                table: "fatocartao",
                column: "TimeID");

            migrationBuilder.CreateIndex(
                name: "IX_fatoclassificacao_TimeID",
                table: "fatoclassificacao",
                column: "TimeID");

            migrationBuilder.CreateIndex(
                name: "IX_fatogol_JogadorID",
                table: "fatogol",
                column: "JogadorID");

            migrationBuilder.CreateIndex(
                name: "IX_fatogol_PartidaID",
                table: "fatogol",
                column: "PartidaID");

            migrationBuilder.CreateIndex(
                name: "IX_fatogol_TimeID",
                table: "fatogol",
                column: "TimeID");

            migrationBuilder.CreateIndex(
                name: "IX_fatopartida_DataID",
                table: "fatopartida",
                column: "DataID");

            migrationBuilder.CreateIndex(
                name: "IX_fatopartida_EstadioID",
                table: "fatopartida",
                column: "EstadioID");

            migrationBuilder.CreateIndex(
                name: "IX_fatopartida_JuizID",
                table: "fatopartida",
                column: "JuizID");

            migrationBuilder.CreateIndex(
                name: "IX_PontePartidaTime_PARTIDAID",
                table: "PontePartidaTime",
                column: "PARTIDAID");

            migrationBuilder.CreateIndex(
                name: "IX_RefreshTokens_Token",
                table: "RefreshTokens",
                column: "Token",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_RefreshTokens_UserId_ExpiresAt",
                table: "RefreshTokens",
                columns: new[] { "UserId", "ExpiresAt" });

            migrationBuilder.CreateIndex(
                name: "IX_Users_Email",
                table: "Users",
                column: "Email",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Users_Username",
                table: "Users",
                column: "Username",
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "AggArtilharia");

            migrationBuilder.DropTable(
                name: "fatocartao");

            migrationBuilder.DropTable(
                name: "fatoclassificacao");

            migrationBuilder.DropTable(
                name: "fatogol");

            migrationBuilder.DropTable(
                name: "PontePartidaTime");

            migrationBuilder.DropTable(
                name: "RefreshTokens");

            migrationBuilder.DropTable(
                name: "DimJogador");

            migrationBuilder.DropTable(
                name: "fatopartida");

            migrationBuilder.DropTable(
                name: "Users");

            migrationBuilder.DropTable(
                name: "DimClube");

            migrationBuilder.DropTable(
                name: "DimData");

            migrationBuilder.DropTable(
                name: "DimEstadio");

            migrationBuilder.DropTable(
                name: "DimJuiz");
        }
    }
}
