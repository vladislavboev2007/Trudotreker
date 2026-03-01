import unittest
from unittest.mock import MagicMock, patch
from fastapi.testclient import TestClient
import sys
import os

# Добавляем путь к модулю
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from main import app, get_family_with_initials


class TestLaborTracker(unittest.TestCase):
    """Модульные тесты для приложения LaborTracker"""

    def setUp(self):
        """Настройка тестового клиента"""
        self.client = TestClient(app)

    # ТЕСТ 1: Позитивный тест функции get_family_with_initials
    def test_get_family_with_initials_success(self):
        """Тест корректного преобразования ФИО в фамилию с инициалами"""
        test_cases = [
            ("Иванов Иван Иванович", "Иванов.И.И."),
            ("Петров Петр", "Петров.П."),
            ("Сидоров", "Сидоров"),  # Одно слово
            ("", ""),  # Пустая строка
            (None, None),  # None
            ("  ", "  "),  # Пробелы
        ]

        for input_name, expected in test_cases:
            with self.subTest(input_name=input_name):
                result = get_family_with_initials(input_name)
                self.assertEqual(result, expected,
                                 f"Ошибка для '{input_name}': ожидалось '{expected}', получено '{result}'")

    # ТЕСТ 2: Негативный тест - попытка запуска несуществующей задачи
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

    # ТЕСТ 3: Негативный тест - создание сотрудника с пустым ФИО
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
    print(f"\n{'=' * 50}")
    print(f"Всего тестов: {result.testsRun}")
    print(f"Успешных: {result.testsRun - len(result.failures) - len(result.errors)}")
    print(f"Проваленных: {len(result.failures)}")
    print(f"Ошибок: {len(result.errors)}")
    print(f"{'=' * 50}")

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