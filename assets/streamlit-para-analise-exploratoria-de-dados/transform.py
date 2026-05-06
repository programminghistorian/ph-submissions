# Functions
def format_brl(value: float) -> str:
    return f'R$ {value:,.2f}'.replace(',', 'X').replace('.', ',').replace('X', '.')

def expenses_per_month(expenses: list) -> dict:
    result = {}

    for item in expenses:
        key = f'{item["ano"]}-{item["mes"]:02d}'
        value = item.get("valorLiquido", 0)

        result[key] = result.get(key, 0) + value
        data = dict(sorted(result.items()))

    return dict(sorted(result.items()))

def total_expenses(monthly_expenses: dict, format: bool) -> float:

    total = sum(monthly_expenses.values())

    if format:
        total = format_brl(total)

    return total

def top_suppliers(expenses: list, top_n: int = 10) -> dict:
    result = {}

    for item in expenses:
        supplier = item.get("nomeFornecedor", "Unknown")
        value = item.get("valorLiquido", 0)

        result[supplier] = result.get(supplier, 0) + value

    return dict(
        sorted(result.items(), key=lambda x: x[1], reverse=True)[:top_n]
    )

def expense_types(expenses: list) -> dict:
    result = {}

    for item in expenses:
        expense_type = item.get("tipoDespesa", "Other")
        value = item.get("valorLiquido", 0)

        result[expense_type] = result.get(expense_type, 0) + value

    return result