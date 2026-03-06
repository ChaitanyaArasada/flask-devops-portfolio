######################################
# BASE IMAGE
#######################################
# ---------- Stage 1: Builder ----------
# ---------- Builder stage ----------
FROM python:3.11-slim AS builder

WORKDIR /app

# create virtual environment
RUN python -m venv /venv

ENV PATH="/venv/bin:$PATH"

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .


########################################
# MULTI STAGE BUILD
########################################


# ---------- Stage 2: Runtime -----------
FROM gcr.io/distroless/python3

WORKDIR /app

# copy virtual environment
COPY --from=builder /venv /venv

# copy application code
COPY --from=builder /app /app

ENV PATH="/venv/bin:$PATH"

EXPOSE 5000

CMD ["app.py"]
