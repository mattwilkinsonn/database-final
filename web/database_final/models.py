# coding: utf-8
from sqlalchemy import Column, ForeignKey, Integer, TIMESTAMP, Text
from sqlalchemy.dialects.mysql import INTEGER
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base
from dataclasses import dataclass

Base = declarative_base()
metadata = Base.metadata


class City(Base):
    __tablename__ = "city"

    id = Column(INTEGER, primary_key=True)
    name = Column(Text, nullable=False)
    population = Column(Integer, nullable=False)


class Train(Base):
    __tablename__ = "train"

    id = Column(INTEGER, primary_key=True)
    name = Column(Text, nullable=False)
    model = Column(Text, nullable=False)
    cars = Column(Integer, nullable=False)


class Vip(Base):
    __tablename__ = "vip"

    id = Column(INTEGER, primary_key=True)
    points = Column(Integer, nullable=False)

@dataclass
class Passenger(Base):
    __tablename__ = "passenger"

    id = Column(INTEGER, primary_key=True)
    name = Column(Text, nullable=False)
    age = Column(Integer, nullable=False)
    vip_id = Column(ForeignKey("vip.id"), index=True)

    vip = relationship("Vip")


class Station(Base):
    __tablename__ = "station"

    id = Column(INTEGER, primary_key=True)
    name = Column(Text, nullable=False)
    city_id = Column(ForeignKey("city.id"), nullable=False, index=True)

    city = relationship("City")


class Booking(Base):
    __tablename__ = "booking"

    id = Column(INTEGER, primary_key=True)
    train_id = Column(ForeignKey("train.id"), nullable=False, index=True)
    passenger_id = Column(ForeignKey("passenger.id"), nullable=False, index=True)
    station_in = Column(ForeignKey("station.id"), nullable=False, index=True)
    station_out = Column(ForeignKey("station.id"), nullable=False, index=True)

    passenger = relationship("Passenger")
    station = relationship("Station", primaryjoin="Booking.station_in == Station.id")
    station1 = relationship("Station", primaryjoin="Booking.station_out == Station.id")
    train = relationship("Train")


class Employee(Base):
    __tablename__ = "employee"

    id = Column(INTEGER, primary_key=True)
    name = Column(Text, nullable=False)
    role = Column(Text, nullable=False)
    station_id = Column(ForeignKey("station.id"), nullable=False, index=True)
    salary = Column(Integer, nullable=False)

    station = relationship("Station")


class Track(Base):
    __tablename__ = "track"

    id = Column(INTEGER, primary_key=True)
    outgoing_station = Column(ForeignKey("station.id"), nullable=False, index=True)
    incoming_station = Column(ForeignKey("station.id"), nullable=False, index=True)
    length = Column(Integer, nullable=False)

    station = relationship(
        "Station", primaryjoin="Track.incoming_station == Station.id"
    )
    station1 = relationship(
        "Station", primaryjoin="Track.outgoing_station == Station.id"
    )


class TrainStop(Base):
    __tablename__ = "train_stop"

    station_id = Column(ForeignKey("station.id"), primary_key=True, nullable=False)
    train_id = Column(
        ForeignKey("train.id"), primary_key=True, nullable=False, index=True
    )
    time_in = Column(TIMESTAMP, nullable=False)
    time_out = Column(TIMESTAMP, nullable=False)
    stop = Column(Integer, nullable=False)

    station = relationship("Station")
    train = relationship("Train")


class Accident(Base):
    __tablename__ = "accident"

    id = Column(INTEGER, primary_key=True)
    train_id = Column(ForeignKey("train.id"), nullable=False, index=True)
    track_id = Column(ForeignKey("track.id"), nullable=False, index=True)
    time = Column(TIMESTAMP, nullable=False)
    cause = Column(Text, nullable=False)

    track = relationship("Track")
    train = relationship("Train")
