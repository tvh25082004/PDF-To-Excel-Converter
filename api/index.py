import sys
import os

# Thêm ConverterApp vào Python path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))

# Import Flask app từ ConverterApp
from ConverterApp.pdftoexcel import app

# Vercel yêu cầu export handler
handler = app

