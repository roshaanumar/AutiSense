# AutiSense

AI-powered autism early detection and monitoring application — Final Year Project.

**Team:** Roshaan, Amna, Rafey

## Architecture

Flutter Web (frontend/) sends requests to FastAPI (backend/), which connects to Firebase Firestore for data storage.

- **Frontend:** Flutter Web, deployed on Vercel
- **Backend:** FastAPI (Python), deployed on Render
- **Database:** Firebase Firestore

## Live Deployment

- Frontend: https://autisense-phi.vercel.app
- Backend: https://autisense-backend-m4du.onrender.com
- Backend API docs: https://autisense-backend-m4du.onrender.com/docs

Note: the backend is hosted on Render's free tier, which spins down after inactivity. The first request after idle time may take 30–60 seconds to respond.

## Project Structure

AutiSense/
- frontend/ — Flutter Web app
- backend/ — FastAPI server
- README.md

## Local Setup

### Prerequisites

Install these on your machine before starting:
- Git
- Python 3.11+ (avoid 3.13 if possible — some ML libraries lag behind on support)
- Node.js
- Flutter SDK — extract to a path with no spaces (e.g. C:\src\flutter), add the bin folder to PATH, then run flutter doctor

### Clone the repo

git clone https://github.com/roshaanumar/AutiSense.git
cd AutiSense

### Create your own branch

git checkout -b yourname/feature-area

### Backend setup

cd backend
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
uvicorn main:app --reload

Verify: visit http://127.0.0.1:8000 — should show a welcome message in JSON format.

### Frontend setup

cd frontend
flutter pub get
flutter run -d chrome

This should work immediately — Firebase config (firebase_options.dart) is already committed, so you don't need to run flutterfire configure again.

### Verify the full pipeline locally

With both servers running, the app should show a welcome message, a backend confirmation message, and a Firebase connection status, all on one screen.

Note: main.dart currently points to the deployed Render backend URL, not 127.0.0.1:8000. If you want to test against your own local backend, temporarily change the URL in frontend/lib/main.dart back to http://127.0.0.1:8000/ — just don't commit that change.

## Git Workflow

- main is the stable branch — don't commit directly to it
- Create a branch per feature/person: yourname/what-youre-working-on
- Push your branch, then open a Pull Request into main on GitHub
- Get it reviewed (even informally) before merging
- Delete your branch after merging, unless you're still actively using it

## Environment Notes

- Firebase config in firebase_options.dart is public/safe to commit — it is not a secret
- Firestore is currently in test-mode-equivalent rules (open read/write) — this must change before any real user data is stored
- venv/, build/, .dart_tool/ are gitignored — never commit these