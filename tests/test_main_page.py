from requests import get


def test_main_page() -> None:
    assert "The install worked successfully! Congratulations!" in get(" http://127.0.0.1").text
