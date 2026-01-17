import cv2, time

cap = cv2.VideoCapture("/dev/video0")
prev = time.time()

count = 0

while count < 900:  
    ret, frame = cap.read()
    if not ret:
        break
    
    # Count frames and check for exit key
    count += 1
    

now = time.time()
print("FPS:", count / (now - prev))
cap.release()