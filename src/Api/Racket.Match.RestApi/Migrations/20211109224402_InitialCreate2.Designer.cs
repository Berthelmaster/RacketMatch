﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Racket.Match.RestApi.AppDbContext;

namespace Racket.Match.RestApi.Migrations
{
    [DbContext(typeof(DatabaseContext))]
    [Migration("20211109224402_InitialCreate2")]
    partial class InitialCreate2
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("Relational:MaxIdentifierLength", 64)
                .HasAnnotation("ProductVersion", "5.0.11");

            modelBuilder.Entity("Racket.Match.RestApi.Entities.Match", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<int?>("RoomId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("RoomId");

                    b.ToTable("Matches");
                });

            modelBuilder.Entity("Racket.Match.RestApi.Entities.Player", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<int?>("MatchId")
                        .HasColumnType("int");

                    b.Property<string>("Name")
                        .HasColumnType("longtext");

                    b.Property<int>("Team")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("MatchId");

                    b.ToTable("Players");
                });

            modelBuilder.Entity("Racket.Match.RestApi.Entities.Room", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("RoomName")
                        .HasColumnType("longtext");

                    b.HasKey("Id");

                    b.ToTable("Rooms");
                });

            modelBuilder.Entity("Racket.Match.RestApi.Entities.Match", b =>
                {
                    b.HasOne("Racket.Match.RestApi.Entities.Room", null)
                        .WithMany("Matches")
                        .HasForeignKey("RoomId");
                });

            modelBuilder.Entity("Racket.Match.RestApi.Entities.Player", b =>
                {
                    b.HasOne("Racket.Match.RestApi.Entities.Match", "Match")
                        .WithMany("Players")
                        .HasForeignKey("MatchId");

                    b.Navigation("Match");
                });

            modelBuilder.Entity("Racket.Match.RestApi.Entities.Match", b =>
                {
                    b.Navigation("Players");
                });

            modelBuilder.Entity("Racket.Match.RestApi.Entities.Room", b =>
                {
                    b.Navigation("Matches");
                });
#pragma warning restore 612, 618
        }
    }
}