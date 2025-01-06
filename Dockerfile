# Ruby Image
FROM ruby:3.2.2

# Set the working directory inside the container
WORKDIR /app

# Copy the application files into the container
COPY . .

# Install dependencies
RUN bundle install

# Expose the port your app will run on
EXPOSE 9292

# Set the command to run your app
CMD ["bundle", "exec", "rackup", "server/config.ru", "-s", "puma", "-E", "production", "-p", "9292"]
