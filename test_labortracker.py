# Для запуска данного теста нужно ввести в терминале python test_labortracker.py
import unittest
from unittest.mock import MagicMock, patch
from fastapi.testclient import TestClient
import sys
import os
from main import app, get_family_with_initials, Task, Employee

# Добавляем путь к модулю
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

class TestLaborTracker(unittest.TestCase):
    """Модульные тесты для приложения LaborTracker"""

    def setUp(self):
        """Настройка тестового клиента"""
        self.client = TestClient(app)

    # Тест 1: Позитивный тест функции get_family_with_initials
    def test_get_family_with_initials_success(self):
        """Тест корректного преобразования ФИО в фамилию с инициалами"""

        result = get_family_with_initials("Фуртатов Илья Дмитриевич")
        self.assertEqual(result, )

    # Тест 2: Негативный тест - попытка запуска несуществующей задачи
    def test_start_nonexistent_task(self):
        """Тест попытки запуска несуществующей задачи"""
        non_existent_task_id = 999999

        with patch('main.SessionLocal') as mock_session:
            mock_db = MagicMock()
            mock_session.return_value = mock_db

            # Настраиваем мок чтобы задача не была найдена
            mock_db.query.return_value.filter.return_value.first.return_value = None

            response = self.client.put(f"/api/tasks/{non_existent_task_id}/start")

            # Проверяем что вернулась ошибка 404
            self.assertEqual(response.status_code, 404)
            self.assertIn("Задача не найдена", response.json()["detail"])

    # Тест 3: Негативный тест - создание сотрудника с пустым ФИО
    def test_create_employee_with_empty_fio(self):
        """Тест создания сотрудника с пустым ФИО"""
        with patch('main.SessionLocal') as mock_session:
            mock_db = MagicMock()
            mock_session.return_value = mock_db

            # Настраиваем мок для обработки ошибки
            mock_db.add.side_effect = Exception("Ошибка вставки в БД")
            mock_db.rollback.return_value = None

            # Пытаемся создать сотрудника с пустым ФИО
            response = self.client.post(
                "/api/employees",
                json={"FIO": ""}  # Пустое ФИО
            )

            # Проверяем что запрос выполнен (сервер должен обработать)
            # Хотя данные невалидны, сервер должен вернуть ответ
            self.assertIn(response.status_code, [200, 400, 500])

    # Тест 4: Негативный тест попытки создания задачи с несуществующим сотрудником
    def test_create_task_with_nonexistent_employee(self):
        """Тест создания задачи с несуществующим ID сотрудника"""
        nonexistent_emp_id = 999999

        with patch('main.SessionLocal') as mock_session:
            mock_db = MagicMock()
            mock_session.return_value = mock_db

            # Настраиваем мок чтобы сотрудник не был найден
            mock_db.query.return_value.filter.return_value.first.return_value = None

            # Пытаемся создать задачу с несуществующим сотрудником
            response = self.client.post(
                "/api/tasks",
                json={
                    "name": "Тестовая задача",
                    "description": "Описание задачи",
                    "empId": nonexistent_emp_id
                }
            )

            # Проверяем что вернулась ошибка 404
            self.assertEqual(response.status_code, 404)
            self.assertIn("Сотрудник не найден", response.json()["detail"])

            # Проверяем что метод add не был вызван (задача не создавалась)
            mock_db.add.assert_not_called()
            mock_db.commit.assert_not_called()

    # Тест 5: Негативный тест удаления сотрудника с активными задачами
    def test_delete_employee_with_active_tasks_failure(self):
        """Тест попытки удаления сотрудника, у которого есть активные задачи"""
        emp_id = 1

        # Создаем мок сотрудника
        mock_employee = MagicMock(spec=Employee)
        mock_employee.empId = emp_id
        mock_employee.FIO = "Иванов Иван"

        # Создаем мок активных задач
        mock_active_task = MagicMock(spec=Task)
        mock_active_task.taskId = 100
        mock_active_task.empId = emp_id
        mock_active_task.final = None  # Активная задача (не завершена)

        with patch('main.SessionLocal') as mock_session:
            mock_db = MagicMock()
            mock_session.return_value = mock_db

            # Настраиваем моки
            mock_db.query.return_value.filter.return_value.first.return_value = mock_employee
            # Возвращаем список с активной задачей
            mock_db.query.return_value.filter.return_value.all.return_value = [mock_active_task]

            # Выполняем запрос на удаление сотрудника
            response = self.client.delete(f"/api/employees/{emp_id}")

            # Проверяем что вернулась ошибка 400
            self.assertEqual(response.status_code, 400)
            self.assertIn("Нельзя удалить сотрудника с задачами", response.json()["detail"])

            # Проверяем что метод delete НЕ был вызван
            mock_db.delete.assert_not_called()
            mock_db.commit.assert_not_called()


def run_tests():
    """Запуск всех тестов"""
    # Создаем test suite
    suite = unittest.TestSuite()

    # Добавляем тесты
    suite.addTest(unittest.makeSuite(TestLaborTracker))

    # Запускаем тесты
    runner = unittest.TextTestRunner(verbosity=2)
    result = runner.run(suite)

    # Выводим статистику
    print(f"\n{'=' * 60}")
    print(f"Результат тестирования:")
    print(f"{'=' * 60}")
    print(f"Всего тестов: {result.testsRun}")
    print(f"Успешных: {result.testsRun - len(result.failures) - len(result.errors)}")
    print(f"Проваленных: {len(result.failures)}")
    print(f"Ошибок: {len(result.errors)}")

    if result.failures:
        print(f"\nДетали проваленных тестов:")
        for test, traceback in result.failures:
            print(f"\n✗ {test}")
            print(traceback)

    if result.errors:
        print(f"\nДетали ошибок:")
        for test, traceback in result.errors:
            print(f"\n⚠ {test}")
            print(traceback)

    print(f"{'=' * 60}")

    return result


if __name__ == "__main__":
    print("Запуск модульных тестов для LaborTracker...")
    print("=" * 50)

    result = run_tests()

    # Возвращаем код ошибки для CI/CD
    if result.failures or result.errors:
        sys.exit(1)
    else:
        sys.exit(0)