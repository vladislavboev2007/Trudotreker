from sqlalchemy import create_engine, Column, Integer, String, Date, Time, ForeignKey
from sqlalchemy.orm import DeclarativeBase, relationship
from sqlalchemy.orm import sessionmaker

POSTGRESQL_DATABASE_URL = "postgresql+psycopg2://postgres:1234@localhost:5432/LaborTracker"
# POSTGRESQL_DATABASE_URL = "postgresql+psycopg2://user_01:password1@10.115.0.67:5432/edu_practice01_01"
engine = create_engine(POSTGRESQL_DATABASE_URL)

class Base(DeclarativeBase):
    pass

class Employee(Base):
    __tablename__ = "Employee"

    empId = Column(Integer, primary_key=True, index=True)
    FIO = Column(String)


class Task(Base):
    __tablename__ = "Task"

    taskId = Column(Integer, primary_key=True, index=True)
    name = Column(String)
    description = Column(String)
    start = Column(Time)
    final = Column(Time)
    date = Column(Date)
    empId = Column(Integer, ForeignKey('Employee.empId'))  # Исправлено на внешний ключ

    # Связь с сотрудником
    employee = relationship("Employee")

SessionLocal = sessionmaker(autoflush=False, bind=engine)

try:
    with engine.connect() as connection:
        print("✅ Подключение к PostgreSQL успешно")
        # Создаем таблицы
        Base.metadata.create_all(bind=engine)
except Exception as e:
    print(f"❌ Ошибка подключения: {e}")